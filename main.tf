module "iam" {
  source = "./modules/iam"

  acl_server_secret_id      = var.acl_server_secret_id
  gcs_bucket_consul_license = module.object_storage.gcs_bucket_consul_license
  gossip_secret_id          = var.gossip_secret_id
  resource_name_prefix      = var.resource_name_prefix
  service_accounts_client   = var.service_accounts_client
  tls_secret_id             = var.tls_secret_id
}

module "networking" {
  source = "./modules/networking"

  resource_name_prefix    = var.resource_name_prefix
  service_accounts_client = module.iam.service_account_email_client
  service_account_server  = module.iam.service_account_email_server
  ssh_source_ranges       = var.ssh_source_ranges
  subnetwork              = var.subnetwork
}

module "object_storage" {
  source = "./modules/object_storage"

  resource_name_prefix    = var.resource_name_prefix
  consul_license_filepath = var.consul_license_filepath
  consul_license_name     = var.consul_license_name
}

module "user_data" {
  source = "./modules/user_data"

  acl_server_secret_id               = var.acl_server_secret_id
  consul_license_name                = module.object_storage.consul_license_name
  consul_version                     = var.consul_version
  gcs_bucket_consul_license          = module.object_storage.gcs_bucket_consul_license
  gossip_secret_id                   = var.gossip_secret_id
  node_count_servers                 = var.node_count_servers
  resource_name_prefix               = var.resource_name_prefix
  tls_secret_id                      = var.tls_secret_id
  user_supplied_userdata_path_server = var.user_supplied_userdata_path_server
}

module "vm_servers" {
  source = "./modules/vm_servers"

  disk_size            = var.vm_disk_size_servers
  disk_source_image    = var.vm_disk_source_image_servers
  disk_type            = var.vm_disk_type_servers
  machine_type         = var.vm_machine_type_servers
  node_count_servers   = var.node_count_servers
  resource_name_prefix = var.resource_name_prefix
  service_account      = module.iam.service_account_email_server
  subnetwork           = var.subnetwork
  userdata_script      = module.user_data.consul_user_data_server
}
