variable "acl_server_secret_id" {
  type        = string
  description = "Secret id/name given to the google secrets manager secret for the acl server default token"
}

variable "gcs_bucket_consul_license" {
  type        = string
  description = "GCS bucket ID containing Consul license"
}

variable "gossip_secret_id" {
  type        = string
  description = "Secret id/name given to the google secrets manager secret for the Consul gossip encryption key"
}

variable "resource_name_prefix" {
  type        = string
  description = "Prefix for naming resources"
}

variable "service_accounts_client" {
  type        = list(string)
  description = "Optional list of service accounts requiring firewall permissions and IAM role binding to be used with Consul clients."
}

variable "tls_secret_id" {
  type        = string
  description = "Secret id/name given to the google secrets manager secret for the Consul TLS certificates"
}
