resource "google_compute_address" "sq_ip_address" {
  name = "sq-address"
  project   =   var.project
  region  = var.region
}

output "ip_sonarqube" {
    description = "sonarqube public ip"
    value = google_compute_address.sq_ip_address.id
}

data "google_dns_managed_zone" "sq_zone" {
  name = "d-e-l-o-com"
  project   =   var.project
}


resource "google_dns_record_set" "sq" {
  name         = "sonarqube.d-e-l-o.com"
  managed_zone = "d-e-l-o.com"
  type         = "A"
  ttl          = 300

  rrdatas = ["34.105.224.15"]
}