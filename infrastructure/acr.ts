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
    { mode: "strict", maxLength: 50 },
    (name) => new azure.containerregistry.Registry(name, {
      registryName: name,
      resourceGroupName: rg.name,
      location: config.locationShort,

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
  return new azure.authorization.RoleAssignment(`${id}-acr-pull`, {
    scope: acr.id,

    roleDefinitionId: `/subscriptions/${config.subscriptionId}/providers/Microsoft.Authorization/roleDefinitions/7f951dda-4ed3-4680-a7ca-43fe172d538d`,

    principalId: cluster.identityProfile.apply(
      (p: pulumi.Unwrap<typeof cluster.identityProfile>) =>
      p?.kubeletidentity?.objectId!
    ),
  });
}