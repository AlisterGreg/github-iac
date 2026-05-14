You are helping the user generate Terraform configuration for a new GitHub repository in this repo.

Ask the user the following two questions before doing anything else:

1. What is the name of the repository? (e.g. `my-new-repo`)
2. Should branch protection be enabled on `main`?

If the user answers yes to branch protection, ask a follow-up question before proceeding:

3. Which required status checks should pass before merging? (e.g. `Terraform Plan, my-ci-check`) — accept a comma-separated list. If the user is unsure, default to `["Terraform Plan"]`.

Once you have all answers, do the following:

- Derive the Terraform resource identifier by replacing every `-` in the repository name with `_` (e.g. `my-new-repo` → `my_new_repo`).
- Create the file `repositories/<repo-name>.tf` with the content below.

**If branch protection is NOT enabled**, create the file with only the `github_repository` resource:

```hcl
resource "github_repository" "<resource_id>" {
  name       = "<repo-name>"
  visibility = "private"

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
```

**If branch protection IS enabled**, append the branch protection module after the resource block:

```hcl
module "<resource_id>_branch_protection" {
  source          = "../branch-protection"
  repository_id   = github_repository.<resource_id>.node_id
  branch_pattern  = "main"
  required_checks = [<user-provided checks as a properly quoted, comma-separated list>]
}
```

Formatting rules to follow exactly (these match `terraform fmt` output):
- 2-space indentation
- Align all `=` signs within each attribute group using spaces so they line up at the same column
- No trailing whitespace
- Single newline at end of file

After writing the file, tell the user:
- The file path that was created
- A reminder to run `terraform plan` to preview the changes before merging
