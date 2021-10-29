locals {
  consul_user_data_server = templatefile(
    var.user_supplied_userdata_path_server != null ? var.user_supplied_userdata_path_server : "${path.module}/templates/install_consul_server.sh.tpl",
    {
      acl_server_secret_id      = var.acl_server_secret_id
      consul_license_name       = var.consul_license_name
      consul_version            = var.consul_version
      gcs_bucket_consul_license = var.gcs_bucket_consul_license
      gossip_secret_id          = var.gossip_secret_id
      instance_count            = var.node_count_servers
      resource_name_prefix      = var.resource_name_prefix
      tls_secret_id             = var.tls_secret_id
    }
  )
}
