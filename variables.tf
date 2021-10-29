variable "acl_server_secret_id" {
  type        = string
  description = "Secret id/name given to the google secrets manager secret for the acl server default token"
  default     = null
}

variable "consul_license_name" {
  type        = string
  description = "The file name for the Consul license file"
  default     = "consul.hclic"
}

variable "consul_license_filepath" {
  type        = string
  description = "Filepath to location of Consul license file"
}

variable "consul_version" {
  type        = string
  default     = "1.10.2"
  description = "Consul version"
}

variable "gossip_secret_id" {
  type        = string
  description = "Secret id/name given to the google secrets manager secret for the Consul gossip encryption key"
}

variable "node_count_servers" {
  type        = number
  default     = 5
  description = "Number of Consul server nodes to deploy"
}

variable "resource_name_prefix" {
  type        = string
  description = "Prefix for naming resources"

  validation {
    condition     = length(var.resource_name_prefix) < 15 && (replace(var.resource_name_prefix, "_", "") == var.resource_name_prefix) && (replace(var.resource_name_prefix, " ", "") == var.resource_name_prefix)
    error_message = "The resource_name_prefix value must be fewer than 15 characters and may not contain spaces or underscores."
  }
}

variable "service_accounts_client" {
  type        = list(string)
  description = "Optional list of service accounts requiring firewall permissions and IAM role binding to be used with Consul clients."
  default     = null
}

variable "ssh_source_ranges" {
  type        = list(string)
  default     = ["35.235.240.0/20"]
  description = "The source IP address ranges from which SSH traffic will be permitted; these ranges must be expressed in CIDR format. The default value permits traffic from GCP's Identity-Aware Proxy"
}

variable "subnetwork" {
  type        = string
  description = "The self link of the subnetwork in which to deploy resources"
}

variable "tls_secret_id" {
  type        = string
  description = "Secret id/name given to the google secrets manager secret for the Consul TLS certificates"
}

variable "user_supplied_userdata_path_server" {
  type        = string
  description = "(Optional) File path to custom userdata script for Consul servers being supplied by the user"
  default     = null
}

# VM VARS

variable "vm_machine_type_servers" {
  type        = string
  default     = "n2-standard-4"
  description = "VM Machine Type"
}

variable "vm_disk_size_servers" {
  type        = number
  default     = 500
  description = "VM Disk size"
}

variable "vm_disk_source_image_servers" {
  type        = string
  default     = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2004-lts"
  description = "VM Disk source image"
}

variable "vm_disk_type_servers" {
  type        = string
  default     = "pd-ssd"
  description = "VM Disk type. SSD recommended"
}
