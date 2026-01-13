output "service_account_email" {
  description = "Terraform deploy service account email."
  value       = google_service_account.terraform_deploy.email
}
