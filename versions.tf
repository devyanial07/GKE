terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.53.1"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.9.0"
    }
  }
}