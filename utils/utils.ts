import { config } from "../config";

// Default: most Azure resources
export function resourceName(resourceType: string, id: string): string {
  return `${resourceType}-${id}-${config.projectName}-${config.environment}-${config.locationShort}`;
}

// Strict: Storage, ACR, etc.
export function strictResourceName(prefix: string, id: string, maxLength: number): string {
  return `${prefix}${id}${config.projectName}${config.environment}${config.locationShort}`
    .replace(/[^a-zA-Z0-9]/g, "")
    .toLowerCase()
    .slice(0, maxLength);
}

type NameMode = "default" | "strict";

/**
 * Creates a resource with a generated name.
 *
 * - "default": uses hyphens (most Azure resources)
 * - "strict": no hyphens, alphanumeric only, lowercase, with length limit
 *   (required for Storage Accounts, ACR, etc.)
 */
export function createResource<T>(
  resourceType: string,
  id: string,
  options: { mode?: NameMode; maxLength?: number } = {},
  creator: (name: string) => T
): T {
  const mode = options.mode ?? "default";

  const name =
    mode === "strict"
      ? strictResourceName(resourceType, id, options.maxLength ?? 50)
      : resourceName(resourceType, id);

  return creator(name);
}