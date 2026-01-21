variable "project_id" {
  description = "GCP project ID where the security policy is created."
  type        = string
}

variable "name" {
  description = "Cloud Armor security policy name."
  type        = string
  default     = "edge-security-policy"
}

variable "description" {
  description = "Description for the security policy."
  type        = string
  default     = "Edge security policy (WAF + rate limit)"
}

variable "allow_ip_ranges" {
  description = "Optional allowlist CIDRs. If empty, rule is not created."
  type        = list(string)
  default     = []
}

variable "rate_limit_rps" {
  description = "Requests per second threshold for rate limiting."
  type        = number
  default     = 50
}

variable "rate_limit_ban_duration_sec" {
  description = "How long to ban an IP that exceeds rate limits."
  type        = number
  default     = 600
}

variable "default_action" {
  description = "Default action for unmatched traffic (allow or deny(403))."
  type        = string
  default     = "allow"
}
