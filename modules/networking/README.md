# GCP Networking Module

## Required variables

* `resource_name_prefix` - string value to use as a unique identifier for resource names
* `service_account_client` - string value for the target service account for firewall rules for clients
* `service_account_server` - string value for the target service account for firewall rules for servers
* `ssh_source_ranges` - string value for the source IP address ranges from which SSH traffic will be permitted; these ranges must be expressed in CIDR format
* `subnetwork` - string value for the self link of the subnetwork in which to deploy resources

## Example usage

```hcl
module "networking" {
  source = "./modules/networking"

  resource_name_prefix   = "test"
  service_account_client = "test-consul-client@project_id.iam.gserviceaccount.com"
  service_account_server = "test-consul-server@project_id.iam.gserviceaccount.com"
  ssh_source_ranges      = "["35.235.240.0/20"]"
  subnetwork             = "https://www.googleapis.com/compute/v1/projects/project_id/regions/us-west1/subnetworks/subnet-01"
}
```
