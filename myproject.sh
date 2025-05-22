#!/bin/bash

# Azure Windows Server VM Creation Script
# Make sure you are logged into Azure CLI before running: az login

# Variables
RESOURCE_GROUP="class1"
LOCATION="eastus"
VM_NAME="myWindowsVM"
ADMIN_USERNAME="azureuser"
ADMIN_PASSWORD="Azureuser001#"  # Must meet Azure password complexity requirements

# Create Resource Group
echo "Creating resource group: $RESOURCE_GROUP"
az group create \
  --name $RESOURCE_GROUP \
  --location $LOCATION

# Create Windows Server 2022 VM
echo "Creating Windows Server 2022 VM: $VM_NAME"
az vm create \
  --resource-group $RESOURCE_GROUP \
  --name $VM_NAME \
  --image "MicrosoftWindowsServer:WindowsServer:2022-datacenter:latest" \
  --admin-username $ADMIN_USERNAME \
  --admin-password "$ADMIN_PASSWORD" \
  --authentication-type password \
  --size Standard_D2s_v3 \
  --os-disk-name "${VM_NAME}Disk" \
  --output json
  

# Open RDP port 3389
echo "Opening RDP port 3389"
az vm open-port \
  --resource-group $RESOURCE_GROUP \
  --name $VM_NAME \
  --port 3389

echo "VM creation complete."
