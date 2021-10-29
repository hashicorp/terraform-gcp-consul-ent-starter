# EXAMPLE: Secrets Configuration on Consul Nodes

## About This Example

The Consul installation module requires TLS certificates on all the Consul nodes
in the cluster along with a [gossip encryption
key](https://www.consul.io/docs/security/encryption#gossip-encryption). If you
do not already have existing TLS certs and a gossip encryption key that you can
use for these requirements, you can use the example code in this directory to
create them and upload them to
[GCP Secret Manager](https://cloud.google.com/secret-manager/docs/overview).

Additionally, an ACL default server token will be created and stored in the GCP
secret manager to be optionally used with the Consul installation module.

## How to Use This Module

- Ensure your GCP credentials are [configured
   correctly](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication)
- Enable the [Secret Manager API](https://cloud.google.com/secret-manager/docs/reference/rest)
- Configure required (and optional if desired) variables
- Run `terraform init` and `terraform apply`

### Security Note:
- The [Terraform State](https://www.terraform.io/docs/language/state/index.html)
  produced by this code has sensitive data (cert private keys) stored in it.
  Please secure your Terraform state using the [recommendations listed
  here](https://www.terraform.io/docs/language/state/sensitive-data.html#recommendations).

## Required variables

* `project_id` - Name of the GCP project in which to deploy resources
* `region` - GCP region to deploy resources into

## Note

- Please note the following output produced by this Terraform as this
  information will be used as input for the Consul installation module:
   - `acl_server_secret_id`
   - `ca_cert`
   - `gossip_secret_id`
   - `tls_secret_id`
