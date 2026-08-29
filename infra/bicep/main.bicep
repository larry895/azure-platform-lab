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

@description('Maximum expected monthly Azure cost in the subscription billing currency.')
@minValue(1)
param monthlyBudgetAmount int = 50

@description('Budget start date. Must be the first day of a month.')
param budgetStartDate string

@description('Budget end date.')
param budgetEndDate string

@description('Email addresses that receive Azure budget notifications.')
@minLength(1)
param budgetNotificationEmails array

@description('Environment to deploy.')
@allowed([
  'shared'
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

module subscriptionBudget './modules/subscription-budget.bicep' = {
  name: 'deploy-subscription-budget'
  params: {
    budgetName: 'budget-${namePrefix}-monthly'
    budgetAmount: monthlyBudgetAmount
    startDate: budgetStartDate
    endDate: budgetEndDate
    notificationEmails: budgetNotificationEmails
  }
}

output resourceGroup object = {
  environment: targetEnvironment
  id: resourceGroup.outputs.resourceGroupId
  name: resourceGroup.outputs.resourceGroupName
}

output subscriptionBudgetId string = subscriptionBudget.outputs.budgetId