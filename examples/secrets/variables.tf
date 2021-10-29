variable "acl_server_secret_id" {
  type        = string
  description = "Secret id/name given to the google secrets manager secret for the acl server default token"
  default     = "terraform_example_module_consul_acl_server_secret"
}

variable "ca_common_name" {
  default     = "ca.consul"
  description = "DNS name for the certificate authority"
  type        = string
}

variable "gossip_secret_id" {
  type        = string
  description = "Secret id/name given to the google secrets manager secret for the gossip encryption key"
  default     = "terraform_example_module_consul_gossip_secret"
}

variable "project_id" {
  type        = string
  description = "The project ID in which to build resources"
}

variable "region" {
  type        = string
  description = "GCP region in which to launch resources"
}

variable "shared_san" {
  type        = string
  description = "This is a shared server name that the certs for all Consul server nodes contain."
  default     = "server.dc1.consul"
}

variable "tls_secret_id" {
  type        = string
  description = "Secret id/name given to the google secrets manager secret for TLS certificates"
  default     = "terraform_example_module_consul_tls_secret"
}
