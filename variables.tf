variable "github_owner" {
  description = "GitHub username that owns the repositories"
  type        = string
}

variable "github_repositories" {
  description = "GitHub repositories to manage"
  type = map(object({
    description = optional(string)
    homepage    = optional(string)
    topics      = optional(list(string), [])
    visibility  = optional(string, "public")

    enable_issues               = optional(bool, true)
    enable_projects             = optional(bool, false)
    enable_wiki                 = optional(bool, false)
    enable_merge_commit         = optional(bool, false)
    enable_rebase_merge         = optional(bool, false)
    enable_squash_merge         = optional(bool, true)
    enable_update_branch        = optional(bool, true)
    squash_merge_commit_title   = optional(string, "COMMIT_OR_PR_TITLE")
    squash_merge_commit_message = optional(string, "COMMIT_MESSAGES")
    delete_branch_on_merge      = optional(bool, true)
  }))

  validation {
    condition = alltrue([
      for repo in values(var.github_repositories) :
      repo.visibility == null || contains(["public", "private", "internal"], repo.visibility)
    ])
    error_message = "visibility must be one of: 'public', 'private', 'internal'."
  }

  validation {
    condition = alltrue([
      for repo in values(var.github_repositories) :
      repo.squash_merge_commit_title == null || contains(["COMMIT_OR_PR_TITLE", "PR_TITLE"], repo.squash_merge_commit_title)
    ])
    error_message = "squash_merge_commit_title must be one of: 'COMMIT_OR_PR_TITLE', 'PR_TITLE'."
  }

  validation {
    condition = alltrue([
      for repo in values(var.github_repositories) :
      repo.squash_merge_commit_message == null || contains(["BLANK", "COMMIT_MESSAGES", "PR_BODY"], repo.squash_merge_commit_message)
    ])
    error_message = "squash_merge_commit_message must be one of: 'BLANK', 'COMMIT_MESSAGES', 'PR_BODY'."
  }
}

variable "github_issue_labels" {
  description = "Issue labels to manage on every repository, keyed by name"
  type = map(object({
    color       = string
    description = optional(string)
  }))
  default = {
    "bug" = {
      color       = "d73a4a"
      description = "Something isn't working"
    }
    "documentation" = {
      color       = "0075ca"
      description = "Improvements or additions to documentation"
    }
    "duplicate" = {
      color       = "cfd3d7"
      description = "This issue or pull request already exists"
    }
    "enhancement" = {
      color       = "a2eeef"
      description = "New feature or request"
    }
    "help-wanted" = {
      color       = "008672"
      description = "Extra attention is needed"
    }
    "inactive" = {
      color       = "cfd3d7"
      description = "Hasn't had activity in 60 days"
    }
    "invalid" = {
      color       = "e4e669"
      description = "This doesn't seem right"
    }
    "need-more-info" = {
      color       = "d876e3"
      description = "Further information is requested"
    }
    "pinned" = {
      color       = "f9348a"
      description = "Will not be marked with the inactive label"
    }
    "question" = {
      color       = "d4c5f9"
      description = "A question or general inquiry"
    }
    "wontfix" = {
      color       = "ffffff"
      description = "This will not be worked on"
    }
  }
}
