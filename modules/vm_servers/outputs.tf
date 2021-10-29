output "instance_group_servers" {
  value = google_compute_region_instance_group_manager.consul.instance_group
}
