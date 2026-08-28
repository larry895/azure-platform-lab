# Azure authentication

GitHub Actions authenticates to Azure using OpenID Connect (OIDC) workload identity federation.

This avoids creating or storing a long-lived Azure client secret in GitHub.

## Identity

The GitHub Actions identity consists of:

- Microsoft Entra application: `github-azure-platform-lab-dev`
- Microsoft Entra service principal
- Federated identity credentials for the GitHub `dev-preview` and `dev` environments
- Azure `Contributor` role scoped to the dedicated lab subscription

The app registration defines the identity. The service principal represents that identity in the tenant and receives Azure role assignments.

## Trust boundary

Azure trusts OIDC tokens issued by GitHub for:

- Repository: `larry895/azure-platform-lab`
- GitHub environments: `dev-preview` and `dev`
- Audience: `api://AzureADTokenExchange`

The subject uses GitHub's repository and owner IDs, binding the credential to the original repository rather than relying only on reusable names.

Both GitHub environments permit workflows only from `main`. The `dev` environment requires manual approval before its deployment job can start. The `dev-preview` environment does not require approval.

## GitHub configuration

The following values are stored as variables on both GitHub environments:

- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`

The following deployment values are stored on `dev-preview` and passed unchanged from the what-if job to the deployment job:

- `AZURE_RESOURCE_OWNER`
- `AZURE_BUDGET_NOTIFICATION_EMAIL`

These values are identifiers, not passwords.

Jobs requiring Azure authentication must:

1. Reference the appropriate GitHub environment.
2. Have `id-token: write` permission.
3. Use the pinned `azure/login` action.
4. Supply the three environment variables to the login action.

## Current permissions

The service principal has the Azure `Contributor` role scoped only to `sub-platform-lab-001`.

This permits the lab workflow to preview and deploy subscription-scoped Bicep resources but does not permit Azure role assignment management.

The preview and deployment jobs currently use the same service principal. The approval is therefore an operational control enforced by the workflow and GitHub environment, not a strict separation of Azure privileges. A future security-hardening change should introduce separate preview and deployment identities with custom least-privilege roles.

## Authentication workflow

The `Azure authentication` workflow is manually triggered and performs only:

1. OIDC authentication.
2. Subscription-context verification.

It does not deploy or modify Azure resources.
