# Azure authentication

GitHub Actions authenticates to Azure using OpenID Connect (OIDC) workload identity federation.

This avoids creating or storing a long-lived Azure client secret in GitHub.

## Identity

The GitHub Actions identity consists of:

- Microsoft Entra application: `github-azure-platform-lab-dev`
- Microsoft Entra service principal
- Federated identity credential for the GitHub `dev` environment
- Azure `Reader` role scoped to the dedicated lab subscription

The app registration defines the identity. The service principal represents that identity in the tenant and receives Azure role assignments.

## Trust boundary

Azure trusts OIDC tokens issued by GitHub for:

- Repository: `larry895/azure-platform-lab`
- GitHub environment: `dev`
- Audience: `api://AzureADTokenExchange`

The subject uses GitHub's repository and owner IDs, binding the credential to the original repository rather than relying only on reusable names.

The `dev` GitHub environment permits deployments only from `main`.

## GitHub configuration

The following values are stored as variables on the GitHub `dev` environment:

- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`

These values are identifiers, not passwords.

Jobs requiring Azure authentication must:

1. Reference the `dev` environment.
2. Have `id-token: write` permission.
3. Use the pinned `azure/login` action.
4. Supply the three environment variables to the login action.

## Current permissions

The service principal currently has only the Azure `Reader` role.

This is sufficient to verify authentication and inspect the selected subscription, but it cannot deploy or modify Azure resources.

Deployment permissions will be introduced separately and should be limited to the permissions required by the infrastructure deployment.

## Authentication workflow

The `Azure authentication` workflow is manually triggered and performs only:

1. OIDC authentication.
2. Subscription-context verification.

It does not deploy or modify Azure resources.