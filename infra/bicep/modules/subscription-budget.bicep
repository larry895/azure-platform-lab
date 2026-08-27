targetScope = 'subscription'

@description('Name of the subscription budget.')
param budgetName string = 'budget-platform-lab-monthly'

@description('Monthly budget amount in the subscription billing currency.')
@minValue(1)
param budgetAmount int = 50

@description('Budget start date, using the first day of a month.')
param startDate string

@description('Budget end date.')
param endDate string

@description('Email addresses that receive budget notifications.')
@minLength(1)
param notificationEmails array

resource budget 'Microsoft.Consumption/budgets@2024-08-01' = {
  name: budgetName
  properties: {
    amount: budgetAmount
    category: 'Cost'
    timeGrain: 'Monthly'
    timePeriod: {
      startDate: startDate
      endDate: endDate
    }
    notifications: {
      Actual_50_Percent: {
        enabled: true
        operator: 'GreaterThanOrEqualTo'
        threshold: 50
        thresholdType: 'Actual'
        contactEmails: notificationEmails
        contactGroups: []
        contactRoles: [
          'Owner'
        ]
        locale: 'sv-se'
      }
      Actual_80_Percent: {
        enabled: true
        operator: 'GreaterThanOrEqualTo'
        threshold: 80
        thresholdType: 'Actual'
        contactEmails: notificationEmails
        contactGroups: []
        contactRoles: [
          'Owner'
        ]
        locale: 'sv-se'
      }
      Actual_100_Percent: {
        enabled: true
        operator: 'GreaterThanOrEqualTo'
        threshold: 100
        thresholdType: 'Actual'
        contactEmails: notificationEmails
        contactGroups: []
        contactRoles: [
          'Owner'
        ]
        locale: 'sv-se'
      }
      Forecasted_100_Percent: {
        enabled: true
        operator: 'GreaterThanOrEqualTo'
        threshold: 100
        thresholdType: 'Forecasted'
        contactEmails: notificationEmails
        contactGroups: []
        contactRoles: [
          'Owner'
        ]
        locale: 'sv-se'
      }
    }
  }
}

output budgetId string = budget.id