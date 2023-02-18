resource "google_project_service" "api_iam" {
  project = var.project
  service = "iam.googleapis.com"
}

resource "google_project_service" "api_iap" {
  project = var.project
  service = "iap.googleapis.com"
}