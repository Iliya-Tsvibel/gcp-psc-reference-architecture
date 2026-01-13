variable "project_id" {
  description = "GCP project ID."
  type        = string
}

variable "workload_identity_pool_id" {
  description = "Workload Identity Pool ID."
  type        = string
}

variable "workload_identity_pool_display_name" {
  description = "Workload Identity Pool display name."
  type        = string
  default     = "github-actions-pool"
}

variable "workload_identity_pool_provider_id" {
  description = "Workload Identity Pool Provider ID."
  type        = string
}

variable "workload_identity_pool_provider_display_name" {
  description = "Workload Identity Pool Provider display name."
  type        = string
  default     = "github-actions-provider"
}

variable "github_org" {
  description = "GitHub organization or user name."
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name."
  type        = string
}
