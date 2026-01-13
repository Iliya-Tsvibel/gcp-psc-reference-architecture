# GCP PSC Reference Architecture - Terraform Foundation

This repository provides a minimal Terraform foundation for two GCP projects:
- **project-a**: perimeter / internet-facing entry point (future external load balancer).
- **project-b**: private workloads (future internal load balancer, GKE, etc.).

## Local usage (plan only)

### Bootstrap flow (one-time setup)

1. Run a local plan in `envs/bootstrap/project-a` and `envs/bootstrap/project-b` using elevated **bootstrap roles** to create the Workload Identity Pool/Provider and a **bootstrap-only** service account (e.g., `tf-bootstrap`). These roles are intentionally broader to allow WIF/SA/IAM setup without service account keys.
2. Record the **bootstrap outputs** and pass them into the runtime environments as variables:
   - `workload_identity_pool_name`
   - `workload_identity_pool_provider_name`
   - `bootstrap_service_account_email`
3. After bootstrap, use the per-project environment folders (e.g., `envs/project-a/dev`) with **runtime roles** only. These are restricted to networking changes and intended for day-to-day Terraform runs via GitHub Actions WIF. The runtime deployer service account (e.g., `tf-deployer`) is created only in these environments.
4. Keep bootstrap permissions separate and used only for initial provisioning or WIF rotations. This repository is plan-only; there are no apply workflows.

### Bootstrap SA vs Runtime SA

- **Bootstrap SA (`tf-bootstrap`)**: created only in `envs/bootstrap/*`, granted **bootstrap_roles** only, and does **not** receive a GitHub OIDC impersonation binding.
- **Runtime SA (`tf-deployer`)**: created only in `envs/project-*/dev`, granted **runtime_roles** only, and is the **only** service account GitHub Actions can impersonate.

**Outputs to copy from bootstrap:**
- `workload_identity_pool_name`
- `workload_identity_pool_provider_name`
- `bootstrap_service_account_email`

**Runtime output to capture for CI:**
- `service_account_email`

### Security rationale

- **Least privilege:** runtime roles are restricted to network and firewall management only; bootstrap roles are elevated and used once on a separate bootstrap service account.
- **Blast radius control:** identity roots (WIF pool/provider) are created in bootstrap and not touched by runtime plans.
- **Accidental deletion protection:** `prevent_destroy` is applied to the WIF pool/provider and deployer service account.

From an environment directory, initialize and plan:

```bash
cd envs/project-a/dev
terraform init
terraform plan -var "project_id=YOUR_PROJECT_ID" \
  -var "region=YOUR_REGION" \
  -var "network_name=project-a-vpc" \
  -var "subnets=[{name=\"project-a-subnet\",region=\"YOUR_REGION\",cidr=\"10.10.0.0/24\",private_google_access=true}]" \
  -var "existing_workload_identity_pool_name=WORKLOAD_IDENTITY_POOL_NAME" \
  -var "github_org=YOUR_GITHUB_ORG" \
  -var "github_repo=YOUR_GITHUB_REPO" \
  -var "service_account_id=tf-deployer"
