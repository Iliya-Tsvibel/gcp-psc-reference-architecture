resource "google_compute_global_address" "ip" {
  project = var.project_id
  name    = "${var.name}-ip"
}

resource "google_compute_managed_ssl_certificate" "cert" {
  project = var.project_id
  name    = "${var.name}-cert"

  managed {
    domains = var.domains
  }
}

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
  port_name             = "http"
  timeout_sec           = 30
  load_balancing_scheme = "EXTERNAL_MANAGED"
  health_checks         = [google_compute_health_check.hc.id]

  dynamic "backend" {
    for_each = var.backend_groups
    content {
      group = backend.value
    }
  }

  security_policy = var.cloud_armor_policy_id
}

resource "google_compute_url_map" "urlmap" {
  project         = var.project_id
  name            = "${var.name}-urlmap"
  default_service = google_compute_backend_service.backend.id
}

resource "google_compute_target_https_proxy" "proxy" {
  project          = var.project_id
  name             = "${var.name}-https-proxy"
  url_map          = google_compute_url_map.urlmap.id
  ssl_certificates = [google_compute_managed_ssl_certificate.cert.id]
}

resource "google_compute_global_forwarding_rule" "fwd" {
  project               = var.project_id
  name                  = "${var.name}-https"
  target                = google_compute_target_https_proxy.proxy.id
  ip_address            = google_compute_global_address.ip.address
  port_range            = "443"
  load_balancing_scheme = "EXTERNAL_MANAGED"
}
