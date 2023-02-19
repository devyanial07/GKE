resource "google_artifact_registry_repository" "sq_repo" {
  location      = var.region
  repository_id = "sonar-docker"
  description   = "sonarqube docker repository"
  format        = "DOCKER"
}

resource "google_artifact_registry_repository" "sq_repo" {
  location      = var.region
  repository_id = "web-app"
  description   = "webapp docker repository"
  format        = "DOCKER"
}