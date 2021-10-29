# Example: GCP Consul Client Module

## About This Example

This example will create a three node cluster of Consul clients.

To deploy this module, a preconfigured service account with role bindings to allow Consul auto-join, GCP Secrets Manager secret access, and storage bucket access will be required, as well as a GCP storage bucket ID containing the Consul Enterprise license.

If running this module with the Consul Enterprise Starter module, a default service account and storage bucket will be configured for this use and appropriate values output from the module, or you may provide a list of service accounts to the starter module to establish those permissions on each service account.

Once the client nodes are provisioned, you must create an ACL
policy for them and attach the pre-generated token (similar to what is shown in
the main module
[README](https://github.com/hashicorp/terraform-gcp-consul-ent-starter/blob/main/README.md)
for the servers) before they are able to join the Consul cluster using cloud
auto-join.

## How to Use This Module

- Ensure your GCP credentials are [configured
   correctly](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication)
- Enable the following services:
  - [Cloud Resource Manager API](https://cloud.google.com/resource-manager/reference/rest)
  - [Secret Manager API](https://cloud.google.com/secret-manager/docs/reference/rest)
  - [Compute Engine API](https://cloud.google.com/compute/docs/reference/rest/v1)
  - GCP Identity & Access Management (IAM)
  - GCP Cloud Storage
- Set the required (and optional as desired) variables in terraform.tfvars (the values below are example values. Be sure to change them):

```
ca_cert = <<-EOT
-----BEGIN CERTIFICATE-----
...
-----END CERTIFICATE-----
EOT

gcs_bucket_consul_license_bucket_name = "test-consul-license-xxxxxxxxxx"
gossip_secret_id                      = "terraform_example_module_consul_gossip_secret"
project_id                            = "my_project_id"
region                                = "us-west1"
resource_name_prefix                  = "test"
service_account                       = "test-consul-client@my_project_id.iam.gserviceaccount.com"
subnetwork                            = "https://www.googleapis.com/compute/v1/projects/my-project-id/regions/us-west1/subnetworks/subnet-01"
```
- Run `terraform init` and `terraform apply`

## Required variables

* `ca_cert` - string value of the certificate authority public certificate
* `gcs_bucket_consul_license_bucket_name` - string value of the GCS bucket ID containing the Consul license
* `gossip_secret_id` - string value of the secret ID/name given to the Google secrets manager secret for the gossip encryption key
* `project_id` - string value of the project ID in which to build resources
* `region` - string value of the GCP region in which to launch resources
* `resource_name_prefix` - string value to use as a unique identifier for resource names
* `service_account` - string value for the service account email address for clients
* `subnetwork` - string value for the self link of the subnetwork in which to deploy resources

## Note:

- For your convenience, a file named `terraform.tfvars.example` has been
  provided in this directory with all of the required variables listed. If you
  would like to use this file, rename it to `terraform.tfvars` and fill in the
  values.
