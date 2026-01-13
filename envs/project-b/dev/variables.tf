variable "project_id" {
  description = "Project ID for project-b."
  type        = string
}

variable "region" {
  description = "Default region for resources."
  type        = string
}

variable "network_name" {
  description = "VPC network name."
  type        = string
}

variable "subnets" {
  description = "Subnet definitions for project-b."
  type = list(object({
    name                  = string
    region                = string
    cidr                  = string
    private_google_access = bool
  }))
}

variable "existing_workload_identity_pool_name" {
  description = "Existing Workload Identity Pool resource name from bootstrap."
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

  validation {
    condition     = var.service_account_id != "tf-bootstrap"
    error_message = "service_account_id must not be the bootstrap service account (tf-bootstrap)."
  }
}

variable "runtime_roles" {
  description = "Project-level roles for day-to-day Terraform runs."
  type        = list(string)
  default = [
    "roles/compute.networkAdmin",
    "roles/compute.securityAdmin"
  ]
}
