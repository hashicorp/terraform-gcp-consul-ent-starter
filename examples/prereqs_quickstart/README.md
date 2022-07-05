# EXAMPLE: Prerequisite Configuration (VPC and Secrets)

## About This Example

The quickstart directory provides example code that will create one GCP VPC
along with a GCP Secret Manager secrets containing TLS certs, a gossip encryption key,
and an ACL default server token.

The GCP VPC will have the following:
- Cloud Router and Cloud NAT
- Google Compute Network
- One subnet

## How to Use This Module

1. Ensure GCP credentials are in [place](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication) (e.g. `gcloud auth application-default login` on your workstation)
2. Configure required (and optional if desired) variables
3. Run `terraform init` and `terraform apply`

## Required variables

* `project_id` - The GCP project ID in which to launch resources
* `region` - The GCP region in which to launch resources

### Security Note:
- The [Terraform State](https://www.terraform.io/docs/language/state/index.html)
  produced by this code has sensitive data (cert private keys) stored in it.
  Please secure your Terraform state using the [recommendations listed
  here](https://www.terraform.io/docs/language/state/sensitive-data.html#recommendations).

## Note:

- The following output is only required if you are using the [example code](https://github.com/hashicorp/terraform-gcp-consul-ent-starter/tree/main/examples/client) to spin up clients
   - `ca_cert`
