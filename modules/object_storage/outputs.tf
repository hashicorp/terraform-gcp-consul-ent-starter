output "gcs_bucket_consul_license" {
  value = google_storage_bucket.consul_license_bucket.name
}

output "consul_license_name" {
  value = var.consul_license_name
}
