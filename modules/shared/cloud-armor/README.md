# Module: Cloud Armor

## Purpose
This module creates a Cloud Armor Security Policy that can be attached to external-facing load balancers.
It includes:
- Optional IP allowlist rule (when provided)
- Basic rate limiting / temporary banning
- Example preconfigured WAF rule (SQLi)
- Default action (allow by default)

## Why it belongs here
Cloud Armor is a cross-cutting security control that should be defined centrally and attached consistently.
Keeping it as a shared module supports repeatability, auditing, and least surprise across environments.

## Notes
This repository is plan-only. The module is generic and does not assume any specific backend type.
Attach the output policy ID to a backend service (external LB) when needed.
