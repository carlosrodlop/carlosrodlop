# Carlosrodlop

This Mono-repo aims to be my entry point for daily work. I iam to do everything as code, creating reusable assets:

* `.docker` Docker containers
  * Images created via [![Push Devops Image](https://github.com/carlosrodlop/carlosrodlop/actions/workflows/docker-buildAndPush-devops.yml/badge.svg)](https://github.com/carlosrodlop/carlosrodlop/actions/workflows/docker-buildAndPush-devops.yml)
* `docs/book` Personal Notes on Tech
  * Actions:
    * [![Book to PDF](https://github.com/carlosrodlop/carlosrodlop/actions/workflows/book-to-pdf.yml/badge.svg)](https://github.com/carlosrodlop/carlosrodlop/actions/workflows/book-to-pdf.yml)
    * [![Update Index](https://github.com/carlosrodlop/carlosrodlop/actions/workflows/book-update-index.yaml/badge.svg)](https://github.com/carlosrodlop/carlosrodlop/actions/workflows/book-update-index.yaml)
* `docs/cv` [CV as JSON](https://jsonresume.org/)
  * Linkedin CV exported via [LinkedIn to JSON Resume Browser Tool](https://github.com/joshuatz/linkedin-to-jsonresume)
  * Action: [![CV to HTML](https://github.com/carlosrodlop/carlosrodlop/actions/workflows/cv-to-html.yaml/badge.svg)](https://github.com/carlosrodlop/carlosrodlop/actions/workflows/cv-to-html.yaml)
* `src/gist`  Bucket for snippets of code
* `src/config` (🔒) Configuration of my workstation
  * Containing secrets encrypted via [SOPS](https://github.com/mozilla/sops)
* `src/secrets` (🔒) Secrets Bucket
  * Encrypted via [Git-crypt](https://github.com/AGWA/git-crypt)

[Pre-commit hooks](https://pre-commit.com/#install) to validate:
* Formats
* Secrets leaks, including <img alt="gitleaks badge" src="https://img.shields.io/badge/protected%20by-gitleaks-blue">
* Ensure not uploading not encrypted [SOPS](https://github.com/mozilla/sops) secrets
