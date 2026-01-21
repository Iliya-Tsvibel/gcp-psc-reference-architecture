variable "project_id" {
  description = "GCP project ID."
  type        = string
}

variable "region" {
  description = "GCP region."
  type        = string
}

variable "name" {
  description = "Base name for ILB resources."
  type        = string
  default     = "int-lb"
}

variable "network" {
  description = "VPC self_link or name."
  type        = string
}

variable "subnetwork" {
  description = "Subnet self_link or name."
  type        = string
}

variable "backend_groups" {
  description = "List of backend groups (NEG/instance group self_links)."
  type        = list(string)
  default     = []
}

variable "health_check_path" {
  description = "HTTP health check path."
  type        = string
  default     = "/"
}

variable "ssl_certificates" {
  description = "List of SSL certificate self_links (self-managed) for internal HTTPS proxy."
  type        = list(string)
  default     = []
}
