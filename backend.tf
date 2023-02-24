terraform {
  backend "gcs" {
    bucket  = "tfstate_delo"
    prefix  = "gke"
  }
}
