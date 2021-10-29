resource "google_compute_instance_template" "consul_server" {
  name_prefix  = "${var.resource_name_prefix}-consul"
  machine_type = var.machine_type

  tags = ["${var.resource_name_prefix}-consul"]

  metadata_startup_script = var.userdata_script

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

  description          = "The instance template of the compute deployment for Consul servers."
  instance_description = "An instance of the compute deployment for a Consul server."

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_region_instance_group_manager" "consul" {
  name = "${var.resource_name_prefix}-consul-servers-group-manager"

  base_instance_name = "${var.resource_name_prefix}-consul-server-vm"

  target_size = var.node_count_servers

  version {
    instance_template = google_compute_instance_template.consul_server.self_link
  }
}
