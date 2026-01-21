output "cluster_name" {
  description = "GKE cluster name."
  value       = google_container_cluster.this.name
}

output "endpoint" {
  description = "Cluster endpoint (private/public depends on config)."
  value       = google_container_cluster.this.endpoint
}

output "node_pool_name" {
  description = "Primary node pool name."
  value       = google_container_node_pool.primary.name
}
