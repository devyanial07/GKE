terraform {
  backend "gcs" {
    bucket  = "tfstate_delo"
    prefix  = "gke"
    project = var.project
  }
}