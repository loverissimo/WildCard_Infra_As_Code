import { createResourceGroup } from "./infrastructure/rg";
import { createACR, grantAcrPullToAks } from "./infrastructure/acr";
import { createAKS } from "./infrastructure/aks";
import { createBlobContainer, createStorageAccount } from "./infrastructure/st";

// Resource Group
const rg = createResourceGroup("main");

// ACR
const acr = createACR(rg, "main", "Basic");

// AKS
const aks = createAKS(rg, "main");

// AKS → ACR (pull access)
grantAcrPullToAks("main", aks, acr);

// Storage Account
const sta = createStorageAccount(rg, "main", "Standard_LRS");

// Blob Container
const blob = createBlobContainer(sta, rg, "main");