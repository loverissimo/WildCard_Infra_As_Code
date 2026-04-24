import * as azure from "@pulumi/azure-native";
import { createResource } from "../utils/utils";
import { config } from "../config";
import { getTags } from "../tags";

export function createStorageAccount(
  rg: azure.resources.ResourceGroup,
  id: string,
  skuName: string = "Standard_LRS",
  extraTags?: Record<string, string>
): azure.storage.StorageAccount {

  return createResource("st", id, (name) => {
    return new azure.storage.StorageAccount(name, {
      accountName: name,
      resourceGroupName: rg.name,
      location: config.locationShort,

      sku: {
        name: skuName,
      },

      kind: "StorageV2",

      tags: getTags(extraTags),
    });
  });
}

export function createBlobContainer(
  storage: azure.storage.StorageAccount,
  rg: azure.resources.ResourceGroup,
  id: string
): azure.storage.BlobContainer {

  return createResource("blob", id, (name) => {
    return new azure.storage.BlobContainer(name, {
      accountName: storage.name,
      resourceGroupName: rg.name,

      publicAccess: azure.storage.PublicAccess.None,
    });
  });
}