resource "github_repository" "github_iac" {
  name        = "github-iac"
  description = "GitHub Infrastructure as Code — Terraform configuration for managing GitHub resources."
  visibility  = "public"

  has_issues   = true
  has_wiki     = false
  has_projects = false

  allow_merge_commit     = false
  allow_squash_merge     = true
  allow_rebase_merge     = false
  delete_branch_on_merge = true

  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
}

module "github_iac_branch_protection" {
  source          = "../branch-protection"
  repository_id   = github_repository.github_iac.node_id
  branch_pattern  = "main"
  required_checks = ["Terraform Plan"]
}
