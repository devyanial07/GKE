module "project_api" {
  source = "terraform-google-modules/project-factory/google//modules/project_services"
  project_id                  = var.project
  disable_services_on_destroy = false
  activate_apis = [
    "dns.googleapis.com",
    "iam.googleapis.com",
    "iap.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com"
  ]
}
