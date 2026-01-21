variable "project_id" {
  description = "GCP project ID."
  type        = string
}

variable "name" {
  description = "Base name for LB resources."
  type        = string
  default     = "ext-lb"
}

variable "domains" {
  description = "Domains for Google-managed SSL certificate."
  type        = list(string)
}

variable "backend_groups" {
  description = "List of backend groups (instance group or NEG self_links)."
  type        = list(string)
  default     = []
}

variable "health_check_path" {
  description = "HTTP health check path."
  type        = string
  default     = "/"
}

variable "cloud_armor_policy_id" {
  description = "Optional Cloud Armor policy ID to attach to backend service."
  type        = string
  default     = null
}
