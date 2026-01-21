output "security_policy_id" {
  description = "Security policy ID."
  value       = google_compute_security_policy.this.id
}

output "security_policy_name" {
  description = "Security policy name."
  value       = google_compute_security_policy.this.name
}
