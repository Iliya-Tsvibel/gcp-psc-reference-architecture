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

module "network" {
  source = "../../../modules/shared/network"

  project_id   = var.project_id
  network_name = var.network_name
  subnets      = var.subnets
}

module "deployer_sa" {
  source = "../../../modules/shared/deployer-sa"

  project_id                  = var.project_id
  workload_identity_pool_name = var.existing_workload_identity_pool_name
  github_org                  = var.github_org
  github_repo                 = var.github_repo
  service_account_id          = var.service_account_id
  runtime_roles               = var.runtime_roles

  allow_bootstrap_roles            = false
  bootstrap_roles                  = []
  create_wif_impersonation_binding = true
}
