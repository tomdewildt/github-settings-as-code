# GitHub Settings As Code

[![License](https://img.shields.io/github/license/tomdewildt/github-settings-as-code)](https://github.com/tomdewildt/github-settings-as-code/blob/master/LICENSE)

Manage [GitHub](https://github.com/) repository settings, branch protection, and labels across personal repositories using the [Terraform GitHub provider](https://registry.terraform.io/providers/integrations/github/latest/docs).

# How To Run

Prerequisites:

- mise version `2025.1.0` or later
- terraform version `1.5.0` or later
- gh cli version `2.92.0` or later

### Development

1. Run `mise run init` to initialize the environment.
2. Run `mise run provision` to provision the GitHub settings.

# References

[Terraform Docs](https://developer.hashicorp.com/terraform/docs)

[Terraform GitHub Provider Docs](https://registry.terraform.io/providers/integrations/github/latest/docs)

[GitHub REST API Docs](https://docs.github.com/en/rest)
