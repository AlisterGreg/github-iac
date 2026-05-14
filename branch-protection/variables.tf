variable "repository_id" {
  description = "The node ID or name of the repository to apply branch protection to."
  type        = string
}

variable "branch_pattern" {
  description = "The branch name pattern the protection rule applies to (e.g. 'main')."
  type        = string
  default     = "main"
}

variable "required_checks" {
  description = "List of status check contexts that must pass before merging."
  type        = list(string)
  default     = []
}