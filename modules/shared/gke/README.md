# Module: GKE (Private)

## Purpose
This module provisions a minimal private GKE cluster with:
- Workload Identity enabled
- Private nodes (no public node IPs)
- Separate node pool (default node pool removed)
- Basic logging/monitoring

## Why it belongs here
GKE is a core workload substrate for the private project (project-b) in this architecture.
Putting it under shared modules keeps the design consistent and allows environments to enable it later without refactoring.

## Notes
This module is intentionally generic. It expects:
- existing VPC/subnet
- secondary IP ranges for pods/services (for VPC-native cluster)

This repository is plan-only.
