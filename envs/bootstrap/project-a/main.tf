terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "wif_bootstrap" {
  source = "../../../modules/shared/wif-bootstrap"

  project_id                         = var.project_id
  workload_identity_pool_id          = var.workload_identity_pool_id
  workload_identity_pool_provider_id = var.workload_identity_pool_provider_id
  github_org                         = var.github_org
  github_repo                        = var.github_repo
}

module "bootstrap_sa" {
  source = "../../../modules/shared/deployer-sa"

  project_id                       = var.project_id
  workload_identity_pool_name      = module.wif_bootstrap.workload_identity_pool_name
  github_org                       = var.github_org
  github_repo                      = var.github_repo
  service_account_id               = var.bootstrap_service_account_id
  create_wif_impersonation_binding = false
  allow_bootstrap_roles            = true
  bootstrap_roles                  = var.bootstrap_roles
  runtime_roles                    = []
}
