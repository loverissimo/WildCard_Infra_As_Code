import * as pulumi from "@pulumi/pulumi";

const cfg = new pulumi.Config();

export const config = {
  projectName: cfg.get("project") ,
  location: cfg.require("location"),
  location_short: cfg.get("location_short"),
  environment: pulumi.getStack(),
  subscriptionId: cfg.require("subscriptionId"),
};