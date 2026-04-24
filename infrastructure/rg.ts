import * as azure from "@pulumi/azure-native";
import { createResource } from "../utils/utils";
import { config } from "../config";
import { getTags } from "../tags";

export function createResourceGroup(
  id: string,
  extraTags?: Record<string, string>
): azure.resources.ResourceGroup {

  return createResource(
    "rg",
    id,
    {}, // default naming
    (name) => new azure.resources.ResourceGroup(name, {
      resourceGroupName: name,
      location: config.locationShort,
      tags: getTags(extraTags),
    })
  );
}