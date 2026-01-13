variable "project_id" {
  description = "GCP project ID."
  type        = string
}

variable "network_name" {
  description = "VPC network name."
  type        = string
}

variable "subnets" {
  description = "List of subnets to create."
  type = list(object({
    name                   = string
    region                 = string
    cidr                   = string
    private_google_access  = bool
  }))
}
