# Security Manifesto 🔒

## Configuration and Secrets as Code as Private Repositories

- Configuration of my workstation and apps is saved as in private repositories.
- Secrets too but additionally are encrypted using [Git-crypt](https://github.com/AGWA/git-crypt).

## Demos as Public Repository

- Sensitive information (domains, telephones, emails, secrets) is only kept locally in `.env` files which are excluded from the remote repository via `.gitignore`.
  - `.env.example` contains sample values.
- Integration with [gitleaks](https://github.com/zricethezav/gitleaks#pre-commit) and [git-secrets](https://cloudbees.atlassian.net/wiki/spaces/ENG/pages/1271400222/Git+Secrets#1.-Global) via pre-commit to avoid uploading any unwanted secret.
- Workloads are intended to be behind the VPN.
