import { config } from "../config";

type NameMode = "default" | "strict";

/**
 * default:  uses hyphens (readable, Azure-friendly)
 * strict:   no hyphens, lowercase, alphanumeric only
 */
export function resourceName(
  resourceType: string,
  id: string,
  mode: NameMode = "default"
): string {
  const raw =
    mode === "strict"
      ? `${resourceType}${id}${config.projectName}${config.environment}${config.location_short}`
      : `${resourceType}-${id}-${config.projectName}-${config.environment}-${config.location_short}`;

  return mode === "strict"
    ? raw.replace(/[^a-zA-Z0-9]/g, "").toLowerCase()
    : raw;
}

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
  options: { mode?: NameMode } = {},
  creator: (name: string) => T
): T {
  const mode = options.mode ?? "default";

  const name = resourceName(resourceType, id, mode);

  return creator(name);
}