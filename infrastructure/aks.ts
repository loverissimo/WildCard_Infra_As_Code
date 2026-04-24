import * as azure from "@pulumi/azure-native";
import { createResource } from "../utils/utils";
import { config } from "../config";
import { getTags } from "../tags";

export function createAKS(
  rg: azure.resources.ResourceGroup,
  id: string,
  extraTags?: Record<string, string>
) {
  const policy = getAksPolicy();

  const cluster = createResource("aks", id, (name) => {
    return new azure.containerservice.ManagedCluster(name, {
      resourceGroupName: rg.name,
      location: config.locationShort,

      dnsPrefix: `${name}-dns`,
      kubernetesVersion: policy.k8sVersion,

      identity: { type: "SystemAssigned" },

      sku: {
        name: "Basic",
        tier: "Free",
      },

      agentPoolProfiles: [
        {
          name: "systempool",
          count: policy.nodeCount,
          vmSize: policy.vmSize,
          mode: "System",
          osType: "Linux",
          type: "VirtualMachineScaleSets",
        },
      ],

      networkProfile: {
        networkPlugin: "azure",
        loadBalancerSku: "standard",
      },

      tags: getTags(extraTags),
    });
  });
}

export function getAksPolicy() {
  switch (config.environment) {
    case "prod":
      return {
        nodeCount: 3,
        vmSize: "Standard_D2s_v3",
        k8sVersion: "1.29.0",
      };

    default:
      return {
        nodeCount: 1,
        vmSize: "Standard_B2s",
        k8sVersion: "1.29.0",
      };
  }
}