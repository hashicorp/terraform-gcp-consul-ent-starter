variable "acl_client_secret_id" {
  type        = string
  description = "Secret id/name given to the google secrets manager secret for the acl client default token"
  default     = "terraform_example_module_consul_acl_client_secret"
}

variable "ca_cert" {
  type        = string
  description = "Certificate Authority public cert"
}

variable "consul_license_name" {
  type        = string
  description = "The file name for the Consul license file"
  default     = "consul.hclic"
}

variable "consul_version" {
  type        = string
  default     = "1.10.2"
  description = "Consul version"
}

variable "disk_size" {
  type        = number
  description = "VM Disk size"
  default     = 500
}

variable "disk_source_image" {
  type        = string
  description = "VM Disk source image"
  default     = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2004-lts"
}

variable "disk_type" {
  type        = string
  description = "VM Disk type. SSD recommended"
  default     = "pd-ssd"
}

variable "gcs_bucket_consul_license_bucket_name" {
  type        = string
  description = "GCS bucket ID containing Consul license"
}

variable "gossip_secret_id" {
  type        = string
  description = "Secret id/name given to the google secrets manager secret for the gossip encryption key"
}

variable "machine_type" {
  type        = string
  description = "VM Machine Type"
  default     = "n2-standard-4"
}

variable "node_count_clients" {
  type        = number
  description = "Number of Consul nodes to deploy"
  default     = 3
}

variable "project_id" {
  type        = string
  description = "The project ID in which to build resources"
}

variable "region" {
  type        = string
  description = "GCP region in which to launch resources"
}

variable "resource_name_prefix" {
  type        = string
  description = "Prefix for naming resources"
}

variable "service_account" {
  type        = string
  description = "Service account for Consul servers"
}

variable "subnetwork" {
  type        = string
  description = "Subnetwork self link in which to deploy instances"
}

variable "user_supplied_userdata_path_client" {
  type        = string
  description = "(Optional) File path to custom userdata script for Consul clients being supplied by the user"
  default     = null
}
