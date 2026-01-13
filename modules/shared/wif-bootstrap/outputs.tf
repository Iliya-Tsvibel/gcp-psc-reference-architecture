output "workload_identity_pool_name" {
  description = "Workload Identity Pool resource name."
  value       = google_iam_workload_identity_pool.pool.name
}

output "workload_identity_pool_provider_name" {
  description = "Workload Identity Pool Provider resource name."
  value       = google_iam_workload_identity_pool_provider.provider.name
}
