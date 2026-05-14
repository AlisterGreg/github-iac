provider "github" {
  owner = var.github_organization
}

module "repositories" {
  source = "./repositories"
}
