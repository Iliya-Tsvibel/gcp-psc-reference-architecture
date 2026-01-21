# Module: Internal HTTPS Load Balancer (Regional)

## Purpose
This module defines a minimal Internal HTTPS Load Balancer (regional):
- Backend service that accepts backend groups (NEGs / instance groups)
- URL map + HTTPS proxy
- Regional forwarding rule (INTERNAL_MANAGED)
- Self-managed SSL certificates passed in as inputs (minimal approach)

## Why it belongs here
The private project (project-b) typically exposes internal services via an internal LB.
This is also a natural anchor point for Private Service Connect producer side (service attachment) in later stages.

## Notes
This module is intentionally minimal and generic.
It does not assume GKE or Ingress; backends are passed as backend groups.

This repository is plan-only.
