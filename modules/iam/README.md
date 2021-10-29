# GCP IAM Module

## Required variables

* `gcs_bucket_consul_license` - GCS bucket ID containing Consul license
* `gossip_secret_id` - string value of the secret id/name given to the google secrets manager secret for the Consul gossip encryption key
* `resource_name_prefix` - string value to use as a unique identifier for resource names
* `tls_secret_id` - string value of the secret id/name given to the google secrets manager secret for the Consul TLS certificates

## Example usage

```hcl
module "iam" {
  source = "./modules/iam"

  gcs_bucket_consul_license = "test-consul-license"
  gossip_secret_id          = "terraform_example_module_consul_gossip_secret"
  resource_name_prefix      = "test"
  service_accounts_client   = "test-consul-client@project_id.iam.gserviceaccount.com"
  tls_secret_id             = "terraform_example_module_consul_tls_secret"
}
```
