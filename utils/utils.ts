import { config } from "../config";

export function resourceName(resourceType: string, uniqueId: string): string {
  return `${resourceType}-${uniqueId}-${config.projectName}-${config.environment}-${config.locationShort}`;
}

export function createResource<T>(
  resourceType: string,
  id: string,
  creator: (name: string) => T
): T {
  const name = resourceName(resourceType, id);
  return creator(name);
}