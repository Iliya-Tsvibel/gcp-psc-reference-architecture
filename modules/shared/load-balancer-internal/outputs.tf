output "forwarding_rule" {
  description = "Forwarding rule self link."
  value       = google_compute_forwarding_rule.fwd.self_link
}
