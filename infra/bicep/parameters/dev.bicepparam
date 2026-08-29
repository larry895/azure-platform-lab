using '../main.bicep'

param location = 'swedencentral'
param namePrefix = 'platform-lab'
param resourceOwner = readEnvironmentVariable('AZURE_RESOURCE_OWNER')
param targetEnvironment = 'dev'

param monthlyBudgetAmount = 50
param budgetStartDate = readEnvironmentVariable('AZURE_BUDGET_START_DATE')
param budgetEndDate = readEnvironmentVariable('AZURE_BUDGET_END_DATE')
param budgetNotificationEmails = [
  readEnvironmentVariable('AZURE_BUDGET_NOTIFICATION_EMAIL')
]