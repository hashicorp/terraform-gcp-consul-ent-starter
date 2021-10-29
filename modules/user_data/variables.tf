variable "acl_server_secret_id" {
  type        = string
  description = "Secret id/name given to the google secrets manager secret for the acl server default token"
}

variable "consul_license_name" {
  type        = string
  description = "Name of Consul license file"
}

variable "consul_version" {
  type        = string
  description = "Consul version"
}

variable "gcs_bucket_consul_license" {
  type        = string
  description = "GCS bucket ID containing Consul license"
}

variable "gossip_secret_id" {
  type        = string
  description = "Secret id/name given to the google secrets manager secret for the gossip encryption key"
}

variable "node_count_servers" {
  type        = number
  default     = 5
  description = "Number of Consul server nodes to deploy"
}

variable "resource_name_prefix" {
  type        = string
  description = "Prefix for naming resources"
}

variable "tls_secret_id" {
  type        = string
  description = "Secret id/name given to the Google Secret Manager secret for the Consul TLS certificates"
}

variable "user_supplied_userdata_path_server" {
  type        = string
  description = "File path to custom userdata script for Consul servers being supplied by the user"
}
