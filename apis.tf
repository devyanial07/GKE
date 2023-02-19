module "project_api" {
  source = "terraform-google-modules/project-factory/google//modules/project_services"
  project_id                  = var.project
  disable_services_on_destroy = false
  activate_apis = [
    "iam.googleapis.com",
    "iap.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "domains.googleapis.com",
    "artifactregistry.googleapis.com",
    "sqladmin.googleapis.com",
    "servicenetworking.googleapis.com",
    "networkmanagement.googleapis.com",
    "containerregistry.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "dns.googleapis.com"
  ]
}
