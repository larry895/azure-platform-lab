# Cost management

This lab uses an Azure subscription budget to provide early warning of unexpected spending.

## Monthly budget

The default monthly budget is `50` in the subscription billing currency. The amount can be overridden during deployment without changing the reusable budget module.

The configured notifications are:

| Cost condition | Cost type |
| --- | --- |
| 50% of budget | Actual |
| 80% of budget | Actual |
| 100% of budget | Actual |
| 100% of budget | Forecasted |

Notifications are sent to the supplied email addresses and users assigned the Azure subscription `Owner` role.

## Important limitation

An Azure budget sends notifications but does not stop, disable, or delete resources when a threshold is reached. Resources can continue generating costs after the budget has been exceeded.

Resources should therefore be removed or stopped when they are no longer required.

## Budget dates

The budget start and end dates are deployment parameters because Azure validates them at deployment time. The start date must use the first day of a month.

Budget dates are not hard-coded in the reusable module, preventing committed dates from becoming outdated.