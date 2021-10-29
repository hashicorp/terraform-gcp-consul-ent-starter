# Consul Enterprise GCP Module

This is a Terraform module for provisioning [Consul Enterprise](https://www.consul.io/docs/enterprise) on GCP.
This module defaults to setting up a cluster with 5 Consul server nodes (as recommended
by the [Consul Reference
Architecture](https://learn.hashicorp.com/tutorials/consul/reference-architecture#failure-tolerance)).

## About This Module
This module implements the [Consul single datacenter Reference
Architecture](https://learn.hashicorp.com/tutorials/consul/reference-architecture)
on GCP using the Enterprise version of Consul 1.10+.

## How to Use This Module

- Ensure your GCP credentials are [configured
  correctly](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication)
  and have permission to use the following GCP services:
    - [Cloud Resource Manager API](https://cloud.google.com/resource-manager/reference/rest)
    - [Compute Engine API](https://cloud.google.com/compute/docs/reference/rest/v1)
    - GCP Identity & Access Management (IAM)
    - GCP Cloud Storage
    - [Secret Manager API](https://cloud.google.com/secret-manager/docs/reference/rest)

- To deploy without an existing VPC, use the [example VPC](https://github.com/hashicorp/terraform-gcp-consul-ent-starter/tree/main/examples/gcp-vpc)
  code to build out the pre-requisite environment. Ensure you are selecting a
  region that has at least three [
  zones](https://cloud.google.com/compute/docs/regions-zones).

- To deploy into an existing VPC, ensure the following components exist and are
  routed to each other correctly:
  - Google Compute Network: manages a VPC network
  - Subnet: a single subnet in which to deploy the Consul cluster
  - One Cloud Router and [Cloud NAT](https://cloud.google.com/nat/docs/overview): the provided user data script requires outbound internet access to download & configure Consul

- Use the [example](https://github.com/hashicorp/terraform-gcp-consul-ent-starter/tree/main/examples/secrets) code to create TLS certs, ACL token, and a gossip token, all
  stored in the [GCP Secret Manager](https://cloud.google.com/secret-manager/docs/overview)


- Create a Terraform configuration that pulls in the Consul module and specifies
  values for the required variables:

```hcl
provider "google" {
  project = "my-project-id"
  region = "us-west1"
}

module "consul-ent" {
  source = "github.com/hashicorp/terraform-gcp-consul-ent-starter"

  # The secret id/name given to the google secrets manager secret for the Consul gossip encryption key
  gossip_secret_id             = "terraform_example_module_consul_gossip_secret"
  # Prefix for uniquely identifying GCP resources
  resource_name_prefix         = "test"
  # Self link of the subnetwork you wish to deploy into
  subnetwork                   = "https://www.googleapis.com/compute/v1/projects/my-project-id/regions/us-west1/subnetworks/subnet-01"
  # Secret id/name given to the google secret manager tls secret
  tls_secret_id                = "terraform_example_module_consul_tls_secret"
  # Path to Consul Enterprise license file
  consul_license_filepath       = "/Users/user/Downloads/consul.hclic"
}
```

  - Run `terraform init` and `terraform apply`

  - To finish configuring your Consul cluster securely and allow access to the Consul CLI, you must
    [bootstrap](https://learn.hashicorp.com/tutorials/consul/access-control-setup-production)
    the ACL system after Consul cluster creation. Begin by logging into your Consul
    cluster:
      - SSH: you must provide a cidr range value for the `ssh_source_ranges` variable.
        The default value is a range provided by google for use with the
        [Identity-Aware Proxy](https://cloud.google.com/iap) service.
          - Please note this Consul cluster is not public-facing. If you want to
            use SSH from outside the VPC, you are required to establish your own
            connection to it (VPN, etc).

  - To bootstrap the ACL system, run the following commands:

  ```bash
  consul acl bootstrap
  ```

  - Please securely store the bootstrap token (shown as the `SecretID`) the Consul returns to you.
  - Use the bootstrap token to create an appropriate policy for your Consul servers and associate their token with it. E.g., assuming `test` as the module's `resource_name_prefix`:

  ```bash
  export CONSUL_HTTP_TOKEN="<your bootstrap token>"
  cat << EOF > consul-servers-policy.hcl
  node_prefix "test-consul-server-vm" {
    policy = "write"
  }
  operator = "write"
  EOF
  consul acl policy create -name consul-servers -rules @consul-servers-policy.hcl
  consul acl token create -policy-name consul-servers -secret "<your server token in acl_tokens_secret_id>"
  unset CONSUL_HTTP_TOKEN
  ```

  - To check the status of your Consul cluster, run the [list-peers](https://www.consul.io/commands/operator/raft#list-peers) command:

  ```bash
  consul operator raft list-peers
  ```

- Now clients can be configured to connect to the cluster. For an example, see the following code in the [examples](https://github.com/hashicorp/terraform-gcp-consul-ent-starter/tree/main/examples/client) directory.

## License

This code is released under the Mozilla Public License 2.0. Please see
[LICENSE](https://github.com/hashicorp/terraform-gcp-consul-ent-starter/tree/main/LICENSE) for more details.
