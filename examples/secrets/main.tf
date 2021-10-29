provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_secret_manager_secret" "secret_tls" {
  secret_id = var.tls_secret_id

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "secret_version_tls" {
  secret = google_secret_manager_secret.secret_tls.id

  secret_data = local.secret
}

resource "google_secret_manager_secret" "secret_gossip" {
  secret_id = var.gossip_secret_id

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "secret_version_gossip_key" {
  secret = google_secret_manager_secret.secret_gossip.id

  secret_data = random_id.gossip_encryption.b64_std
}

resource "random_uuid" "consul_server_default_token" {}

resource "google_secret_manager_secret" "secret_acl_server_token" {
  secret_id = var.acl_server_secret_id

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "secret_version_acl_server_token" {
  secret = google_secret_manager_secret.secret_acl_server_token.id

  secret_data = "default = \"${random_uuid.consul_server_default_token.result}\""
}
