output "network_name" {
  description = "Project B network name."
  value       = module.network.network_name
}

output "service_account_email" {
  description = "Terraform deploy service account email."
  value       = module.deployer_sa.service_account_email
}
