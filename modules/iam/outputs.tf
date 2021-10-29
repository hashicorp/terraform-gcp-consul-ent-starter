output "service_account_email_client" {
  value = var.service_accounts_client == null ? [google_service_account.client[0].email] : var.service_accounts_client
}

output "service_account_email_server" {
  value = google_service_account.server.email
}
