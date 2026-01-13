resource "google_service_account" "terraform_deploy" {
  project      = var.project_id
  account_id   = var.service_account_id
  display_name = var.service_account_display_name

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_service_account_iam_member" "github_wif_impersonation" {
  count = var.create_wif_impersonation_binding ? 1 : 0

  service_account_id = google_service_account.terraform_deploy.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${var.workload_identity_pool_name}/attribute.repository/${var.github_org}/${var.github_repo}"

  # Security: Restrict impersonation to a single GitHub repository.
}

resource "google_project_iam_member" "runtime_roles" {
  for_each = toset(var.runtime_roles)

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.terraform_deploy.email}"

  # Security: Least-privilege roles for day-to-day Terraform runs.
}

resource "google_project_iam_member" "bootstrap_roles" {
  for_each = toset(var.bootstrap_roles)

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.terraform_deploy.email}"

  # Security: Bootstrap-only roles; use only during initial WIF/SA setup.
}
