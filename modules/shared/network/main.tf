resource "google_compute_network" "vpc" {
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "subnets" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }

  name                     = each.value.name
  project                  = var.project_id
  region                   = each.value.region
  ip_cidr_range            = each.value.cidr
  network                  = google_compute_network.vpc.id
  private_ip_google_access = each.value.private_google_access
}

resource "google_compute_firewall" "ingress_deny_all" {
  name    = "${var.network_name}-ingress-deny-all"
  project = var.project_id
  network = google_compute_network.vpc.name

  direction = "INGRESS"
  priority  = 65534

  deny {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]

  # Security: Default GCP ingress is deny; this low-priority rule documents intent
  # while still allowing explicit allow rules to take precedence when added later.
}

resource "google_compute_firewall" "egress_allow_https" {
  name    = "${var.network_name}-egress-allow-https"
  project = var.project_id
  network = google_compute_network.vpc.name

  direction = "EGRESS"
  priority  = 900

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  destination_ranges = ["0.0.0.0/0"]

  # Security: Minimal egress allow rule; expand only as needed.
  # Future: DNS (53), NTP (123), GKE control plane access, Artifact Registry,
  # PSC backends, and Private Google Access/NAT considerations may require
  # additional destinations or dedicated egress paths.
}

resource "google_compute_firewall" "egress_deny_all" {
  name    = "${var.network_name}-egress-deny-all"
  project = var.project_id
  network = google_compute_network.vpc.name

  direction = "EGRESS"
  priority  = 1000

  deny {
    protocol = "all"
  }

  destination_ranges = ["0.0.0.0/0"]

  # Security: Deny all other egress by default.
}
