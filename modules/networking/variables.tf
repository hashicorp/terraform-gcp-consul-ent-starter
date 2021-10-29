variable "resource_name_prefix" {
  type        = string
  description = "Prefix for naming resources"
}

variable "service_accounts_client" {
  type        = list(string)
  description = "Optional list of service accounts requiring firewall permissions and IAM role binding to be used with Consul clients."
}

variable "service_account_server" {
  type        = string
  description = "Target service account for firewall rules for servers"
}

variable "subnetwork" {
  type        = string
  description = "Subnetwork self link in which to deploy instances"
}

variable "ssh_source_ranges" {
  type        = list(string)
  description = "The source IP address ranges from which SSH traffic will be permitted; these ranges must be expressed in CIDR format. The default value permits traffic from GCP's Identity-Aware Proxy"
}
