resource "google_compute_health_check" "hc" {
  project = var.project_id
  name    = "${var.name}-hc"

  http_health_check {
    port_specification = "USE_SERVING_PORT"
    request_path       = var.health_check_path
  }
}

resource "google_compute_backend_service" "backend" {
  project               = var.project_id
  name                  = "${var.name}-backend"
  protocol              = "HTTP"
  timeout_sec           = 30
  load_balancing_scheme = "INTERNAL_MANAGED"
  health_checks         = [google_compute_health_check.hc.id]

  dynamic "backend" {
    for_each = var.backend_groups
    content {
      group = backend.value
    }
  }
}

resource "google_compute_url_map" "urlmap" {
  project         = var.project_id
  name            = "${var.name}-urlmap"
  default_service = google_compute_backend_service.backend.id
}

resource "google_compute_target_https_proxy" "proxy" {
  project = var.project_id
  name    = "${var.name}-https-proxy"
  url_map = google_compute_url_map.urlmap.id

  ssl_certificates = var.ssl_certificates
}

resource "google_compute_forwarding_rule" "fwd" {
  project               = var.project_id
  region                = var.region
  name                  = "${var.name}-https"
  load_balancing_scheme = "INTERNAL_MANAGED"

  network    = var.network
  subnetwork = var.subnetwork

  ip_protocol = "TCP"
  ports       = ["443"]
  target      = google_compute_target_https_proxy.proxy.id
}
