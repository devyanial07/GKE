module "vpc_network" {
  source  = "terraform-google-modules/network/google"
  version = "5.1.0"
  project_id   = var.project
  network_name = var.vpc_network_name
  routing_mode = "GLOBAL"

  subnets = [
    {
        subnet_name   = "${var.vpc_network_name}-primary"
        subnet_ip     = var.primary_subnet_cidr
        subnet_region = var.region
        subnet_private_access = "true"
        subnet_flow_logs      = "true"
        subnet_flow_logs_sampling = 1
        description           = "Primary subnet"
    }
  ]
  secondary_ranges = {
    "${var.vpc_network_name}-primary" = [
      {
        range_name    = "${var.vpc_network_name}-secondary-1"
        ip_cidr_range = var.secondary_subnet_cidr_1
      },
      {
        range_name    = "${var.vpc_network_name}-secondary-2"
        ip_cidr_range = var.secondary_subnet_cidr_2
      },
    ]
  }
}

  
/*  resource "google_compute_address" "router_demo" {
  name         = "varnet-router"
  project      = 
  region       = 
  network_tier = "PREMIUM"
}

resource "google_compute_router" "router_demo" {
  project = 
  name    = "-router"
  network = netwiorkname
  region  = 
}

data "google_compute_address" "router-address" {
  name    = "prjnet-router"
  project = 
  region  = 
}

module "cloud-nat" {
  source                             = "terraform-google-modules/cloud-nat/google"
  version                            = "2.2.0"
  project_id                         = 
  region                             = 
  router                             = google_compute_router.router_demo.name
  name                               = "network-nat"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ips                            = [google_compute_address.router_demo.self_link]
  log_config_enable                   = true
  log_config_filter                 = "ERRORS_ONLY"
}
 */