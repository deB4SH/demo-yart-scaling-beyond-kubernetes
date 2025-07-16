#!/usr/bin/env bash
CONTAINER_NAME='tfstate'
SUBSCRIPTION='12345678-1234-4321-1234-12345678901'
RESOURCE_GROUP_NAME='rg-black-mesa-tf-backend'
STORAGE_ACCOUNT_NAME='halflifetfbackend'
LOCATION=''


# Function to check if a command is installed
check_command_installed() {
    command -v $1 &>/dev/null
    if [ $? -ne 0 ]; then
        echo "$1 is not installed. Please install it and try again."
        exit 1
    fi
}

# Function to check if logged into Azure
check_azure_login() {
    az account show &>/dev/null
    if [ $? -ne 0 ]; then
        echo "Not logged into Azure. Logging in..."
        az login
        if [ $? -ne 0 ]; then
            echo "Azure login failed."
            exit 1
        fi
    else
        echo "Already logged into Azure."
    fi
}

############# functions #################
function azLogin {
    echo "login to azure portal, you will be redirect to the azure portal."
    az login
}

function azSetSubscription {
    az account set --subscription "$SUBSCRIPTION"
}

function azCreateResourceGroup {
    echo "create resource group for storageaccount"
    az group create --name "$RESOURCE_GROUP_NAME" --location "$LOCATION"
    az group lock create --lock-type CanNotDelete -n OnDeleteLock -g "$RESOURCE_GROUP_NAME" --notes ""
}

function azCreateStorageAccount {
    echo "create storageaccount for storageaccount for blob container"
    az storage account create --resource-group "$RESOURCE_GROUP_NAME" --name "$STORAGE_ACCOUNT_NAME" --sku Standard_LRS --encryption-services blob
}

function azGetStorageAccountKey {
    echo "get storageaccount key to create blob container"
    ACCOUNT_KEY=$(az storage account keys list --resource-group "$RESOURCE_GROUP_NAME" --account-name "$STORAGE_ACCOUNT_NAME" --query [0].value -o tsv)
}

function azCreateBlobContainer {
    echo "create blob container to save terraform state"
    az storage container create --name $CONTAINER_NAME --account-name "$STORAGE_ACCOUNT_NAME" --account-key "$ACCOUNT_KEY"
}

function startBootstrapping() {

    azSetSubscription
    azCreateResourceGroup
    azCreateStorageAccount
    azGetStorageAccountKey
    azCreateBlobContainer

}

##### main #######
startBootstrapping