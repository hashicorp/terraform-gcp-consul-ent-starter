terraform {
  required_version = ">= 1.2.1"

  required_providers {
    google = "< 5.0, >= 3.83"
    tls    = ">= 3.0.0, < 4.0.0"
  }
}
