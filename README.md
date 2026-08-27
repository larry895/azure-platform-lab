# Azure Platform Lab

A cost-conscious Azure platform engineering lab built to demonstrate reusable infrastructure, secure deployment automation, identity, governance, networking, and operational practices.

The project models a small internal developer platform for one team and one service. It is intentionally limited in scale and does not represent a production platform.

## Goals

- Provision Azure resources using reusable Bicep modules
- Deploy through GitHub Actions using OpenID Connect
- Avoid long-lived Azure credentials
- Separate development and demonstration environments
- Use managed identities and least-privilege RBAC
- Apply Azure Policy as code
- Explore Azure networking without maintaining expensive services
- Validate infrastructure and scan code before deployment
- Keep resources inexpensive through scale-to-zero and automated cleanup
- Document architecture decisions, costs, security, and operations

## Initial scope

- One dedicated Azure Pay-As-You-Go subscription
- Sweden Central as the default region
- Development and demonstration environments
- Bicep for Azure infrastructure
- PowerShell for bootstrap and operational automation
- GitHub Actions for CI/CD
- Azure Container Apps for scale-to-zero compute
- Azure Blob Storage for application data
- Azure Policy in audit mode before enforcement
- A small Python service added in a later phase

## Out of scope

The initial version will not include:

- Azure Kubernetes Service
- Multiple simulated development teams
- Production workloads
- Always-on compute
- Terraform-managed resources

## Status

Early development. Tooling and repository foundations are being established.