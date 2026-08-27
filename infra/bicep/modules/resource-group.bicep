targetScope = 'subscription'

@description('Name of the resource group.')
@minLength(1)
@maxLength(60)
param resourceGroupName string

@description('Azure region associated with the resource group.')
param location string

@description('Tags applied to the resource group.')
param tags object

resource resourceGroup 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

@description('Resource ID of the resource group.')
output resourceGroupId string = resourceGroup.id

@description('Name of the resource group.')
output resourceGroupName string = resourceGroup.name