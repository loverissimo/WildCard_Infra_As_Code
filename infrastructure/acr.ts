import * as azure from "@pulumi/azure-native";
import * as pulumi from "@pulumi/pulumi";
import { config } from "../config";
import { getTags } from "../tags";

import { createResource } from "../utils/utils";

export function createACR(
  rg: azure.resources.ResourceGroup,
  id: string,
  sku: azure.containerregistry.SkuName = "Basic",
  extraTags?: Record<string, string>
): azure.containerregistry.Registry {

  return createResource(
    "acr",
    id,
    { mode: "strict"},
    (name) => new azure.containerregistry.Registry(name, {
      registryName: name,
      resourceGroupName: rg.name,
      location: config.location,

      sku: { name: sku },
      tags: getTags(extraTags),
    })
  );
}

export function grantAcrPullToAks(
  id: string,
  cluster: azure.containerservice.ManagedCluster,
  acr: azure.containerregistry.Registry
) {
  const principalId = cluster.identityProfile.apply((profile: any) => {
    const kubeletClientId = profile?.kubeletidentity?.clientId;

    if (!kubeletClientId) {
      throw new Error("AKS kubelet identity clientId not available yet");
    }

    return kubeletClientId;
  });

  return new azure.authorization.RoleAssignment(`${id}-acr-pull`, {
    scope: acr.id,

    roleDefinitionId:
      `/subscriptions/${config.subscriptionId}/providers/Microsoft.Authorization/roleDefinitions/7f951dda-4ed3-4680-a7ca-43fe172d538d`,

    principalId,

    principalType: "ServicePrincipal",
  }, {
    dependsOn: [cluster, acr],
  });
}