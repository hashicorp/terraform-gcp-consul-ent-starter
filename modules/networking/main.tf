data "google_compute_subnetwork" "subnetwork" {
  self_link = var.subnetwork
}

locals {
  service_accounts_client_server = concat([var.service_account_server], var.service_accounts_client)
}


resource "google_compute_firewall" "rpc" {
  name    = "${var.resource_name_prefix}-rpc-firewall"
  network = data.google_compute_subnetwork.subnetwork.network

  description = "Firewall to allow servers to handle incoming requests from other agents"

  source_service_accounts = local.service_accounts_client_server

  target_service_accounts = [
    var.service_account_server
  ]

  allow {
    protocol = "tcp"
    ports    = ["8300"]
  }
}

resource "google_compute_firewall" "http_dns_lan" {
  name    = "${var.resource_name_prefix}-http-dns-lan-firewall"
  network = data.google_compute_subnetwork.subnetwork.network

  description = "8500 and 8501 allows clients to talk to the HTTP API, 8600 for DNS queries, 8301 for LAN gossip"

  source_service_accounts = local.service_accounts_client_server

  target_service_accounts = local.service_accounts_client_server

  allow {
    protocol = "tcp"
    ports    = ["8301", "8500", "8501", "8600"]
  }

  allow {
    protocol = "udp"
    ports    = ["8301", "8600"]
  }

}


resource "google_compute_firewall" "ssh" {
  name    = "${var.resource_name_prefix}-ssh-firewall"
  network = data.google_compute_subnetwork.subnetwork.network

  description   = "The firewall which allows the ingress of SSH traffic to Consul instances"
  direction     = "INGRESS"
  source_ranges = var.ssh_source_ranges

  target_service_accounts = local.service_accounts_client_server

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
