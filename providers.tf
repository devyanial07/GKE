terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      #version = "4.53.1"
      version = "2.20.0"
    }
  }
}

provider "google" {
  #project   =   var.project
}