output "network_name" {
  description = "VPC network name."
  value       = google_compute_network.vpc.name
}

output "network_self_link" {
  description = "VPC network self link."
  value       = google_compute_network.vpc.self_link
}

output "subnet_self_links" {
  description = "Subnet self links keyed by subnet name."
  value       = { for name, subnet in google_compute_subnetwork.subnets : name => subnet.self_link }
}
