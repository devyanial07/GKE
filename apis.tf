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
    "dns.googleapis.com",
    "cloudbuild.googleapis.com",
    "containerfilesystem.googleapis.com"
  ]
}
resource "google_project_iam_member" "wordpress_role" {
  for_each = toset([
    "roles/cloudsql.client "
  ])
  role = each.key
  member = "serviceAccount:cloudsql-proxy@champ-392921.iam.gserviceaccount.com"
  project = var.project
}
/*
resource "google_project_iam_member" "gke_sarole" {
  for_each = toset([
    "roles/cloudsql.admin",
    "roles/secretmanager.secretAccessor",
    "roles/datastore.owner",
    "roles/storage.admin",
    "roles/artifactregistry.admin",
    "roles/container.clusterAdmin",
    #"roles/storage.legacyObjectReader"
    "roles/container.developer"
  ])
  role = each.key
  member = "serviceAccount:813165853992-compute@developer.gserviceaccount.com"
  project = var.project
}



resource "google_project_iam_member" "clsvc_role" {
  for_each = toset([
    "roles/cloudsql.admin",
    "roles/secretmanager.secretAccessor",
    "roles/datastore.owner",
    "roles/storage.admin",
    "roles/artifactregistry.admin",
    "roles/container.clusterAdmin",
    "roles/container.developer"
    #"roles/storage.legacyObjectReader"
  ])
  role = each.key
  member = "serviceAccount:813165853992@cloudservices.gserviceaccount.com"
  project = var.project
}
 */