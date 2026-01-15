# GCP PSC Reference Architecture - Terraform Foundation

This repository provides a minimal **Terraform foundation** for two GCP projects:

- **project-a**: perimeter / internet-facing entry point (future External HTTPS Load Balancer + Cloud Armor).
- **project-b**: private workloads (future Internal HTTPS Load Balancer, GKE, etc.).

> **Scope:** plan-only IaC foundation (no apply workflows included).

---

## Local usage (plan only)

### Bootstrap flow (one-time setup)

1. Run a local `terraform plan` in:
   - `envs/bootstrap/project-a`
   - `envs/bootstrap/project-b`

   using elevated **bootstrap roles** to create:
   - a Workload Identity Pool + Provider (GitHub OIDC),
   - a **bootstrap-only** service account (e.g., `tf-bootstrap`).

2. Record the **bootstrap outputs** and pass them into runtime environments as variables:
   - `workload_identity_pool_name`
   - `workload_identity_pool_provider_name`
   - `bootstrap_service_account_email`

3. After bootstrap, use per-project environment folders (e.g., `envs/project-a/dev`) with **runtime roles** only.
   - Runtime creates a deployer service account (e.g., `tf-deployer`)
   - GitHub Actions can impersonate **only** the runtime service account via WIF (no keys)

4. Keep bootstrap permissions separate and use them only for initial provisioning or WIF rotations.
   - This repository remains plan-only; no apply workflows are provided.

---

### Bootstrap SA vs Runtime SA

- **Bootstrap SA (`tf-bootstrap`)**
  - Created only in `envs/bootstrap/*`
  - Granted **bootstrap_roles** only
  - **No** GitHub OIDC impersonation binding (cannot be used by CI)

- **Runtime SA (`tf-deployer`)**
  - Created only in `envs/project-*/dev`
  - Granted **runtime_roles** only (networking + firewall)
  - **Only** service account GitHub Actions can impersonate via WIF

**Outputs to copy from bootstrap:**
- `workload_identity_pool_name`
- `workload_identity_pool_provider_name`
- `bootstrap_service_account_email`

**Runtime output to capture for CI:**
- `service_account_email`

---

## Security rationale

- **Least privilege:** runtime roles are restricted to network and firewall management only; bootstrap roles are elevated and used once on a separate bootstrap service account.
- **Blast radius control:** identity roots (WIF pool/provider) are created in bootstrap and not touched by runtime runs.
- **Accidental deletion protection:** `prevent_destroy` is used for WIF pool/provider and service accounts.

---

## Example: plan from an environment directory

```bash
cd envs/project-a/dev
terraform init
terraform plan \
  -var "project_id=YOUR_PROJECT_ID" \
  -var "region=YOUR_REGION" \
  -var "network_name=project-a-vpc" \
  -var "subnets=[{name=\"project-a-subnet\",region=\"YOUR_REGION\",cidr=\"10.10.0.0/24\",private_google_access=true}]" \
  -var "existing_workload_identity_pool_name=WORKLOAD_IDENTITY_POOL_NAME" \
  -var "github_org=YOUR_GITHUB_ORG" \
  -var "github_repo=YOUR_GITHUB_REPO" \
  -var "service_account_id=tf-deployer"
