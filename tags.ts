import { config } from "../config";

export function getTags(extraTags: Record<string, string> = {}) {
  return {
    project: `${config.projectName}-iac`,
    environment: config.environment,
    managedBy: "pulumi",
    ...extraTags,
  };
}