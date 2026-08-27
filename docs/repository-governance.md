# Repository governance

This document describes the protections applied to the Azure Platform Lab
repository. These settings are configured in GitHub and are not represented by
files in the repository.

## Protected branch

The `protect-main` ruleset targets the repository's default branch, `main`.

The following protections are active:

- Changes must reach `main` through a pull request.
- The `Repository checks` status check must pass before merging.
- A branch must be up to date with `main` before merging.
- Pull request conversations must be resolved before merging.
- Force pushes to `main` are blocked.
- Deletion of `main` is blocked.
- No users or applications are configured to bypass the ruleset.

Approving reviews are not currently required because the repository has one
contributor. This decision should be reconsidered if additional contributors
join the project.

## Repository security

GitHub Secret Protection is enabled for the repository.

The following protections are active:

- Secret scanning detects supported credentials committed to the repository.
- Push protection attempts to block supported credentials before they enter
  Git history.

Credentials, subscription identifiers, tenant configuration, and other
environment-specific values must not be committed. GitHub Actions will use
OpenID Connect to authenticate to Azure without a long-lived client secret.

## Review

These settings were last reviewed on 2026-08-27. Repository protections should
be reviewed whenever the contribution model or deployment process changes.