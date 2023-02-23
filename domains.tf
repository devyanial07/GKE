resource "google_compute_global_address" "sq_address" {
  name = "sq-address"
  project   =   var.project
}

resource "google_compute_global_address" "web_address" {
  name = "web-address"
  project   =   var.project
}

resource "google_compute_global_address" "webaddress" {
  name = "gkeapp-address"
  project   =   var.project
}

data "google_dns_managed_zone" "sq_name_zone" {
  name = "d-e-l-o-com."
  project   =   var.project
}

output "zone_sonarqube" {
    description = "sonarqube zone"
    value = data.google_dns_managed_zone.sq_name_zone.name
}

/* resource "google_dns_record_set" "sq" {
  name         = "sonarqube.${data.google_dns_managed_zone.sq_name_zone.name}"
  managed_zone = data.google_dns_managed_zone.sq_name_zone.name
  type         = "A"
  ttl          = 300

  rrdatas = ["34.105.224.15"]
} */

resource "google_dns_record_set" "webapp" {
  name         = "webapp.d-e-l-o.com."
  managed_zone = "d-e-l-o-com"
  type         = "A"
  ttl          = 300

  rrdatas = ["34.117.179.184"]
}

resource "google_dns_record_set" "gke_webapp" {
  name         = "gkeapp.d-e-l-o.com."
  managed_zone = "d-e-l-o-com"
  type         = "A"
  ttl          = 300

  rrdatas = ["34.111.100.222"]
} 