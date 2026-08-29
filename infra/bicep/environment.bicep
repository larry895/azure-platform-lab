targetScope = 'subscription'

@description('Default Azure region for platform resources.')
param location string = 'swedencentral'

@description('Short name used when constructing Azure resource names.')
@minLength(2)
@maxLength(40)
param namePrefix string = 'platform-lab'

@description('Person responsible for the deployed resources.')
@minLength(1)
param resourceOwner string

@description('Environment to deploy.')
@allowed([
  'dev'
  'demo'
])
param targetEnvironment string

var commonTags = {
  ManagedBy: 'azure-platform-lab'
  ProvisionedBy: 'Bicep'
  Project: 'azure-platform-lab'
  Owner: resourceOwner
}

module resourceGroup './modules/resource-group.bicep' = {
  name: 'deploy-${targetEnvironment}-resource-group'
  params: {
    resourceGroupName: 'rg-${namePrefix}-${targetEnvironment}'
    location: location
    tags: union(commonTags, {
      Environment: targetEnvironment
      Lifecycle: 'persistent'
    })
  }
}

output resourceGroup object = {
  environment: targetEnvironment
  id: resourceGroup.outputs.resourceGroupId
  name: resourceGroup.outputs.resourceGroupName
}