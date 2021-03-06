variable "consul_license_filepath" {
  type        = string
  description = "Filepath to location of Consul license file"
}

variable "consul_license_name" {
  type        = string
  description = "Filename for Consul license file"
}

variable "resource_name_prefix" {
  type        = string
  description = "Prefix for naming resources"
}

variable "storage_location" {
  type        = string
  description = "The location of the storage bucket for the Vault license."
}
