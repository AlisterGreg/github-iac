resource "github_branch_protection" "branch-protection" {
  repository_id = var.repository_id
  pattern       = var.branch_pattern

  enforce_admins = true

  required_linear_history         = true
  require_conversation_resolution = true

  required_status_checks {
    strict   = true
    contexts = var.required_checks
  }
}
