resource "google_compute_global_address" "champ_address" {
  name = "wordpress-champ-address"
  project   =   var.project
}
/* 
resource "google_compute_global_address" "web_address" {
  name = "web-address"
  project   =   var.project
}

resource "google_dns_record_set" "webapp" {
  name         = "webapp.d-e-l-o.com."
  managed_zone = "d-e-l-o-com"
  type         = "A"
  ttl          = 300

  rrdatas = ["34.117.179.184"]
} */