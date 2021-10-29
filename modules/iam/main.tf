locals {
  service_account_client_members = var.service_accounts_client == null ? ["serviceAccount:${google_service_account.client[0].email}"] : formatlist("serviceAccount:%s", var.service_accounts_client)
  service_account_server_member  = ["serviceAccount:${google_service_account.server.email}"]
  service_accounts               = concat(local.service_account_client_members, local.service_account_server_member)
}

resource "random_id" "consul" {
  byte_length = 4
}

resource "google_service_account" "server" {
  account_id   = "${var.resource_name_prefix}-consul-server"
  display_name = "For Consul auto-join, secrets access for Consul servers"
}

resource "google_service_account" "client" {
  count        = var.service_accounts_client == null ? 1 : 0
  account_id   = "${var.resource_name_prefix}-consul-client"
  display_name = "For Consul auto-join, secrets access for Consul clients"
}

resource "google_project_iam_custom_role" "autojoin_role" {
  role_id     = "consulAutojoin${random_id.consul.hex}"
  title       = "consul-auto-join-${random_id.consul.hex}"
  description = "Custom role for Consul auto-join"
  permissions = [
    "compute.zones.list",
    "compute.instances.list"
  ]
}

resource "google_project_iam_binding" "consul_auto_join" {
  members = local.service_accounts
  role    = google_project_iam_custom_role.autojoin_role.name
}

resource "google_secret_manager_secret_iam_member" "secret_manager_member_tls" {
  secret_id = var.tls_secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.server.email}"
}

resource "google_secret_manager_secret_iam_member" "secret_manager_member_acl_server" {
  count     = var.acl_server_secret_id == null ? 0 : 1
  secret_id = var.acl_server_secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.server.email}"
}

resource "google_secret_manager_secret_iam_binding" "secret_manager_member_gossip" {
  secret_id = var.gossip_secret_id
  role      = "roles/secretmanager.secretAccessor"
  members   = local.service_accounts
}

resource "google_storage_bucket_iam_binding" "member_object" {
  bucket  = var.gcs_bucket_consul_license
  role    = "roles/storage.objectViewer"
  members = local.service_accounts
}

resource "google_storage_bucket_iam_binding" "member_bucket" {
  bucket  = var.gcs_bucket_consul_license
  role    = "roles/storage.legacyBucketReader"
  members = local.service_accounts
}
