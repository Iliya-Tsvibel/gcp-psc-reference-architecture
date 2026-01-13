variable "project_id" {
  description = "GCP project ID."
  type        = string
}

variable "workload_identity_pool_name" {
  description = "Existing Workload Identity Pool resource name."
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

variable "service_account_id" {
  description = "Service account ID for Terraform deployments."
  type        = string
}

variable "service_account_display_name" {
  description = "Service account display name."
  type        = string
  default     = "Terraform deployer"
}

variable "create_wif_impersonation_binding" {
  description = "Whether to create the Workload Identity impersonation binding."
  type        = bool
  default     = true
}

variable "allow_bootstrap_roles" {
  description = "Whether bootstrap roles are allowed to be bound by this module."
  type        = bool
  default     = false
}

variable "bootstrap_roles" {
  description = "Project-level roles for initial bootstrap (optional)."
  type        = list(string)
  default     = []

  validation {
    condition     = var.allow_bootstrap_roles || length(var.bootstrap_roles) == 0
    error_message = "bootstrap_roles must be empty unless allow_bootstrap_roles is true."
  }
}

variable "runtime_roles" {
  description = "Project-level roles for day-to-day Terraform runs (networking only)."
  type        = list(string)
  default = [
    "roles/compute.networkAdmin",
    "roles/compute.securityAdmin"
  ]
}
