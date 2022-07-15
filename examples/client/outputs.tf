output "default_acl_token" {
  description = "Consul server default ACL token"
  sensitive   = true
  value       = random_uuid.consul_client_default_token.result
}

output "instance_group_clients" {
  value = google_compute_region_instance_group_manager.consul.instance_group
}
