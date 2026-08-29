using '../environment.bicep'

param location = 'swedencentral'
param namePrefix = 'platform-lab'
param resourceOwner = readEnvironmentVariable('AZURE_RESOURCE_OWNER')
param targetEnvironment = 'demo'