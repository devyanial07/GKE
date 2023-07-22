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
  password = var.pwd 
}

/*
resource "google_sql_user" "postgres_user" {
  instance = google_sql_database_instance.mysql.name
  name     = var.MYSQL_USERNAME
  password  = var.pwd  
} 

resource “google_sql_database_instance” “master” {
name = "instance_name"
database_version = "MYSQL_5_7"
region = "${var.region}"
settings {
tier = "db-n1-standard-2"
}
}
resource "google_sql_database" “database” {
    name = "database_name"
instance = "${google_sql_database_instance.master.name}"
charset = "utf8"
collation = "utf8_general_ci"
}
*/