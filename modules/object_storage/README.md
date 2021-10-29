# GCP Object Storage Module

## Required variables

* `resource_name_prefix` - string value to use as a unique identifier for resource names
* `consul_license_filepath` - string value of the filepath to location of Consul license file
* `consul_license_name` - string value of the filename for Consul license file

## Example usage

```hcl
module "object_storage" {
  source = "./modules/object_storage"

  resource_name_prefix    = "test"
  consul_license_filepath = "/Users/user/Downloads/consul.hclic"
  consul_license_name     = "consul.hclic"
}
```
