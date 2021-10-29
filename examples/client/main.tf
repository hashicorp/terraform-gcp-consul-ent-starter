provider "google" {
  project = var.project_id
  region  = var.region
}

resource "random_uuid" "consul_client_default_token" {}

resource "google_secret_manager_secret" "secret_acl_client_token" {
  secret_id = var.acl_client_secret_id

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "secret_version_acl_client_token" {
  secret = google_secret_manager_secret.secret_acl_client_token.id

  secret_data = "default = \"${random_uuid.consul_client_default_token.result}\""
}

locals {
  consul_user_data_client = templatefile(
    var.user_supplied_userdata_path_client == null ? "${path.module}/templates/install_consul_client.sh.tpl" : var.user_supplied_userdata_path_client,
    {
      acl_client_secret_id      = var.acl_client_secret_id
      ca_cert                   = var.ca_cert
      consul_license_name       = var.consul_license_name
      consul_version            = var.consul_version
      gcs_bucket_consul_license = var.gcs_bucket_consul_license_bucket_name
      gossip_secret_id          = var.gossip_secret_id
      resource_name_prefix      = var.resource_name_prefix
    }
  )
}

resource "google_secret_manager_secret_iam_member" "secret_manager_member_acl_client" {
  secret_id = var.acl_client_secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${var.service_account}"

  depends_on = [
    google_secret_manager_secret_version.secret_version_acl_client_token,
  ]
}

resource "google_compute_instance_template" "consul_client" {
  name_prefix  = "${var.resource_name_prefix}-consul"
  machine_type = var.machine_type

  tags = ["${var.resource_name_prefix}-consul"]

  metadata_startup_script = local.consul_user_data_client

  disk {
    source_image = var.disk_source_image
    auto_delete  = true
    boot         = true
    disk_size_gb = var.disk_size
    disk_type    = var.disk_type
    mode         = "READ_WRITE"
    type         = "PERSISTENT"
  }

  network_interface {
    subnetwork = var.subnetwork
  }

  service_account {
    scopes = ["cloud-platform"]

    email = var.service_account
  }

  description          = "The instance template of the compute deployment for Consul clients."
  instance_description = "An instance of the compute deployment for a Consul client."

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_region_instance_group_manager" "consul" {
  name = "${var.resource_name_prefix}-consul-clients-group-manager"

  base_instance_name = "${var.resource_name_prefix}-consul-client-vm"

  target_size = var.node_count_clients

  version {
    instance_template = google_compute_instance_template.consul_client.self_link
  }
}
