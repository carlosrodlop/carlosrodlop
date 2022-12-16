# My GitHub

## Stats

<p><img align="center" src="https://github-readme-streak-stats.herokuapp.com/?user=carlosrodlop&" alt="carlosrodlop" /></p>

## Submodules

My profile repository is my entry point in my workstation to browse around the following repos

* `docs` Notes on Tech and Certificafiones
* `src` Code Repository
    * `src/config` (🔒) Configuration of my workstation
      * Containing secrets encrypted via [SOPS](https://github.com/mozilla/sops)
* `secrets` (🔒) Secrets Bucket
  * Encrypted via [Git-crypt](https://github.com/AGWA/git-crypt)
  * Vaults: [pass](https://www.passwordstore.org/) and [KeePassX](https://www.keepassx.org/)

Different repositories contains [Pre-commit](https://pre-commit.com) configured to a [set of hooks](https://pre-commit.com/hooks.html) depending on the case, including <img alt="gitleaks badge" src="https://img.shields.io/badge/protected%20by-gitleaks-blue">
