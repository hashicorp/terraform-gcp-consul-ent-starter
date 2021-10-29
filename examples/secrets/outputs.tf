output "ca_cert" {
  description = "Certificate Authority public cert"
  value       = tls_self_signed_cert.ca.cert_pem
}

output "consul_acl_server_secret_id" {
  description = "ACL default token for Consul servers"
  value       = var.acl_server_secret_id

  depends_on = [
    google_secret_manager_secret_version.secret_version_acl_server_token,
  ]
}

output "gossip_secret_id" {
  value       = var.gossip_secret_id
  description = "Secret id/name given to the Google Secret Manager secret for the gossip encryption key"
}

output "tls_secret_id" {
  value       = var.tls_secret_id
  description = "Secret id/name given to the Google Secret Manager secret for the TLS certificates"
}
