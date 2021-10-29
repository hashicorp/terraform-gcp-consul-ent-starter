resource "random_id" "consul" {
  byte_length = 4
}

resource "google_storage_bucket" "consul_license_bucket" {
  name                        = "${var.resource_name_prefix}-consul-license-${random_id.consul.hex}"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "consul_license" {
  name   = var.consul_license_name
  source = var.consul_license_filepath
  bucket = google_storage_bucket.consul_license_bucket.name
}
