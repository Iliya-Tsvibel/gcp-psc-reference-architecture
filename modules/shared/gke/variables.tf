variable "project_id" {
  description = "GCP project ID."
  type        = string
}

variable "region" {
  description = "GCP region."
  type        = string
}

variable "name" {
  description = "Cluster name."
  type        = string
  default     = "private-gke"
}

variable "network" {
  description = "VPC self_link or name."
  type        = string
}

variable "subnetwork" {
  description = "Subnetwork self_link or name."
  type        = string
}

variable "release_channel" {
  description = "RAPID / REGULAR / STABLE"
  type        = string
  default     = "REGULAR"
}

variable "master_ipv4_cidr" {
  description = "Master CIDR for private cluster."
  type        = string
  default     = "172.16.0.0/28"
}

variable "pods_secondary_range_name" {
  description = "Secondary range name for pods."
  type        = string
}

variable "services_secondary_range_name" {
  description = "Secondary range name for services."
  type        = string
}

variable "master_authorized_cidrs" {
  description = "List of CIDRs allowed to reach the control plane."
  type        = list(string)
  default     = []
}

variable "node_count" {
  description = "Number of nodes in the primary node pool."
  type        = number
  default     = 1
}

variable "machine_type" {
  description = "Node machine type."
  type        = string
  default     = "e2-medium"
}

variable "deletion_protection" {
  description = "Protect cluster from deletion."
  type        = bool
  default     = true
}
