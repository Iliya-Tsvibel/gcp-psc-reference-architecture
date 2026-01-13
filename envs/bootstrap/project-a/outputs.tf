output "bootstrap_service_account_email" {
  description = "Bootstrap Terraform service account email."
  value       = module.bootstrap_sa.service_account_email
}

output "workload_identity_pool_name" {
  description = "Workload Identity Pool resource name."
  value       = module.wif_bootstrap.workload_identity_pool_name
}

output "workload_identity_pool_provider_name" {
  description = "Workload Identity Pool Provider resource name."
  value       = module.wif_bootstrap.workload_identity_pool_provider_name
}
