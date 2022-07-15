output "ca_cert" {
  description = "Certificate Authority public cert"
  value       = module.secrets.ca_cert
}

output "consul_acl_server_secret_id" {
  description = "ACL default token for Consul servers"
  value       = module.secrets.consul_acl_server_secret_id
}

output "default_acl_token" {
  description = "Consul server default ACL token"
  sensitive   = true
  value       = module.secrets.default_acl_token
}

output "gossip_secret_id" {
  description = "Secret id/name given to the Google Secret Manager secret for the gossip encryption key"
  value       = module.secrets.gossip_secret_id
}

output "subnetwork" {
  description = "The self-link of subnet being created"
  value       = module.vpc.subnetwork
}

output "tls_secret_id" {
  description = "Secret id/name given to the Google Secret Manager secret for the TLS certificates"
  value       = module.secrets.tls_secret_id
}
