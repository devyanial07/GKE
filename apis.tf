resource "google_project_service" "api_iam" {
  project = var.project
  service = "iam.googleapis.com"
}

resource "google_project_service" "api_iap" {
  project = var.project
  service = "iap.googleapis.com"
}

module "project_dns_api" {
  source = "terraform-google-modules/project-factory/google//modules/project_services"
  project_id                  = var.project
  disable_services_on_destroy = false
  activate_apis = [
    "dns.googleapis.com"
  ]
}
