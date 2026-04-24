import * as pulumi from "@pulumi/pulumi";

const cfg = new pulumi.Config();

export const config = {
  projectName: cfg.get("project") ,
  locationShort: cfg.require("location_short"),
  environment: pulumi.getStack(),
  subscriptionId: cfg.require("subscriptionId"),
};