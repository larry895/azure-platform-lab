# Azure deployment

The `Azure deployment` workflow provides a manually initiated path from Bicep preview to an approved deployment.

## Workflow

The workflow performs these stages:

1. The operator selects a target environment.
2. The what-if job selects the corresponding `.bicepparam` file.
3. Azure produces a subscription deployment preview.
4. The deployment job waits for approval on the target GitHub environment.
5. After approval, the workflow deploys the same commit with the same effective parameters.

Only `dev` is currently available. The `demo` option will be added when `demo.bicepparam` exists and its GitHub environments and OIDC credentials have been configured.

## GitHub environments

The development workflow uses two GitHub environments:

| Environment | Purpose | Required reviewer |
| --- | --- | --- |
| `dev-preview` | Run Azure what-if | No |
| `dev` | Deploy Azure resources | Yes |

Both environments allow only the `main` branch.

Because this repository currently has one maintainer, self-review prevention remains disabled. The maintainer can therefore start the workflow, inspect the what-if result, and approve or reject the deployment job.

## Parameter consistency

The what-if job calculates the budget dates and selects `dev.bicepparam`. It passes those values, the resource owner, and the budget notification email to the deployment job as job outputs.

Both jobs explicitly check out the workflow run's commit. This prevents approval from causing the deployment job to switch to a newer commit.

Azure Bicep what-if is not a saved deployment plan. Azure evaluates the template again during deployment, so Azure state can change between preview and approval even when the commit and parameters remain the same.

## Manual approval

After what-if succeeds, the workflow run displays a pending deployment for `dev`. A required reviewer must inspect the preview and select **Approve and deploy** before the deployment job receives an OIDC token or starts running.

Reject the pending deployment if the preview contains unexpected changes.

## Concurrency

The workflow permits only one active run for a target environment. A new run does not cancel a deployment that is already waiting for approval or running.
