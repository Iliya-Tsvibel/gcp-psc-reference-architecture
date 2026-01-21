output "ip_address" {
  description = "External IP address."
  value       = google_compute_global_address.ip.address
}

output "forwarding_rule" {
  description = "Forwarding rule self link."
  value       = google_compute_global_forwarding_rule.fwd.self_link
}
