terraform {
  backend "gcs" {
    bucket  = "wp-champ-backend"
    prefix  = "champ-wordpress-gke"
  }
}