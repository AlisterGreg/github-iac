provider "github" {
  owner = var.github_organization
  # token is read from the GITHUB_TOKEN environment variable
}
