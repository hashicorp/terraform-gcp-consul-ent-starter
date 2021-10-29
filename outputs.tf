output "service_account_email_client" {
  value = module.iam.service_account_email_client
}

output "gcs_bucket_consul_license_bucket_name" {
  value = module.object_storage.gcs_bucket_consul_license
}
