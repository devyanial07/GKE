locals {
  gke = ["35.189.124.160"]
} 

resource "google_sql_database_instance" "mysql_instance" {
  #instance             = "postgres-instance"
  name             = "${var.MYSQL_DATABASE}-wp"
  database_version = "MYSQL_8_0"
  region           = var.region
  project          = var.project
  deletion_protection = false

  settings {
    tier = "db-f1-micro"
    availability_type = "ZONAL"

    location_preference {
      zone = "europe-west2-a"
    }

    ip_configuration {
      private_network = "projects/${var.project}/global/networks/${var.vpc_network_name}"
      ipv4_enabled    = false

      dynamic "authorized_networks" {
        for_each = local.gke
        iterator = gke
        content {
          name  = "gke-endpoint"
          value = gke.value
        }
      }
    }
  }
}

resource "google_sql_database" "wp_champ_db" {
  name     = var.MYSQL_DATABASE
  instance = google_sql_database_instance.mysql_instance.name
  charset = "utf8"
  collation = "utf8_general_ci"
  #deletion_policy = "ABANDON"
}

resource "google_sql_user" "wordpress_champ_user" {
  name = var.MYSQL_USERNAME
  instance = "${google_sql_database_instance.mysql_instance.name}"
  host = "%"
  password = var.MYSQL_PASSWORD 
}