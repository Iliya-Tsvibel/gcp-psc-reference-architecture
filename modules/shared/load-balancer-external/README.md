# Module: External HTTPS Load Balancer (Global)

## Purpose
This module defines a minimal External HTTPS Load Balancer:
- Global static IP
- Google-managed SSL certificate
- Backend service that accepts backend groups (NEGs / instance groups)
- URL map + HTTPS proxy + forwarding rule
- Optional Cloud Armor attachment

## Why it belongs here
The public perimeter (project-a) typically exposes an external LB as the internet entrypoint.
Keeping it as a shared module preserves consistency and allows security controls (e.g. Cloud Armor) to be attached uniformly.

## Notes
This module is generic and does not assume GKE.
Backend groups should be provided by the environment that owns the actual workloads.

This repository is plan-only.
