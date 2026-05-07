resource "github_repository" "repository" {
  for_each = var.github_repositories

  name         = each.key
  description  = each.value.description
  homepage_url = each.value.homepage
  topics       = each.value.topics
  visibility   = each.value.visibility

  has_issues   = each.value.enable_issues
  has_projects = each.value.enable_projects
  has_wiki     = each.value.enable_wiki

  allow_merge_commit          = each.value.enable_merge_commit
  allow_rebase_merge          = each.value.enable_rebase_merge
  allow_squash_merge          = each.value.enable_squash_merge
  allow_update_branch         = each.value.enable_update_branch
  squash_merge_commit_title   = each.value.squash_merge_commit_title
  squash_merge_commit_message = each.value.squash_merge_commit_message

  delete_branch_on_merge = each.value.delete_branch_on_merge

  lifecycle {
    ignore_changes = [template]
  }
}

resource "github_branch_protection" "branch_protection" {
  for_each = {
    for name, repo in var.github_repositories : name => repo
    if repo.visibility == "public"
  }

  repository_id  = github_repository.repository[each.key].node_id
  pattern        = "master"
  enforce_admins = true

  required_pull_request_reviews {
    required_approving_review_count = 0
  }

  required_status_checks {
    strict = true
  }

  lifecycle {
    ignore_changes = [required_status_checks[0].contexts]
  }
}

resource "github_issue_labels" "issue_labels" {
  for_each = var.github_repositories

  repository = each.key

  dynamic "label" {
    for_each = var.github_issue_labels
    content {
      name        = label.key
      color       = label.value.color
      description = label.value.description
    }
  }
}
