variable "project_id" {
  description = "Project ID for project-a bootstrap."
  type        = string
}

variable "region" {
  description = "Default region for resources."
  type        = string
}

variable "workload_identity_pool_id" {
  description = "WIF pool ID."
  type        = string
}

variable "workload_identity_pool_provider_id" {
  description = "WIF provider ID."
  type        = string
}

variable "github_org" {
  description = "GitHub organization or user name."
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name."
  type        = string
}

variable "bootstrap_service_account_id" {
  description = "Bootstrap service account ID (e.g., tf-bootstrap)."
  type        = string
}

variable "bootstrap_roles" {
  description = "Bootstrap-only roles for creating WIF/SA/IAM bindings."
  type        = list(string)
  default = [
    "roles/iam.workloadIdentityPoolAdmin",
    "roles/iam.serviceAccountAdmin",
    "roles/iam.serviceAccountUser",
    "roles/resourcemanager.projectIamAdmin"
  ]
}
