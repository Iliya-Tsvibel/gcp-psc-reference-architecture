resource "google_compute_security_policy" "this" {
  name        = var.name
  description = var.description
  project     = var.project_id

  dynamic "rule" {
    for_each = length(var.allow_ip_ranges) > 0 ? [1] : []
    content {
      priority = 1000
      action   = "allow"
      match {
        versioned_expr = "SRC_IPS_V1"
        config {
          src_ip_ranges = var.allow_ip_ranges
        }
      }
      description = "Allowlisted source IPs"
    }
  }

  rule {
    priority = 2000
    action   = "rate_based_ban"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    rate_limit_options {
      ban_duration_sec = var.rate_limit_ban_duration_sec
      conform_action   = "allow"
      exceed_action    = "deny(429)"
      rate_limit_threshold {
        count        = var.rate_limit_rps
        interval_sec = 1
      }
    }
    description = "Basic rate limiting"
  }

  rule {
    priority = 3000
    action   = "deny(403)"
    match {
      expr {
        expression = "evaluatePreconfiguredWaf('sqli-v33-stable')"
      }
    }
    description = "Block SQLi patterns (preconfigured WAF)"
  }

  rule {
    priority = 2147483647
    action   = var.default_action
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "Default action"
  }
}
