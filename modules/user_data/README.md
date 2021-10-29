# GCP User Data Module

## Required variables

* `consul_license_name` - string value for the name of Consul license file
* `consul_version` - string value for the Consul version to install
* `gcs_bucket_consul_license` - string value of the GCS bucket ID containing Consul license
* `gossip_secret_id` - string value of the secret id/name given to the google secrets manager secret for the Consul gossip encryption key
* `node_count_servers` - Number of Consul server vms to deploy
* `resource_name_prefix` - string value to use as a unique identifier for resource names
* `tls_secret_id` - string value for the secret id/name given to the google secret manager secret

## Example usage

```hcl
module "user_data" {
  source = "./modules/user_data"

  consul_license_name                = "consul.hclic"
  consul_version                     = "1.10.2"
  gcs_bucket_consul_license          = "test-consul-license"
  gossip_secret_id                   = "terraform_example_module_consul_gossip_secret"
  node_count_servers                 = 5
  resource_name_prefix               = "test"
  tls_secret_id                      = "terraform_example_module_consul_tls_secret"
  user_supplied_userdata_path_server = "/Users/user/Downloads/install_consul_server.sh.tpl"

}
```

## Considerations

To use your own custom user data template, add the path to the `user_supplied_userdata_path_server` variable when running the main module.
