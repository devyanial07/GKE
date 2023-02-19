/* data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke_stateful.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke_stateful.ca_certificate)
} */

provider "google" {
  project   =   var.project
}

provider "helm" {
  kubernetes {
    host                   = "https://${module.gke.endpoint}"
    cluster_ca_certificate = base64decode(module.gke.ca_certificate)
    token                  = data.google_client_config.default.access_token
  }
}