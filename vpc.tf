module "vpc_network" {
  source  = "terraform-google-modules/network/google"
  version = "5.1.0"
#master_ipv4_cidr_block     = "10.0.0.0/28"##
  project_id   = ""
  network_name = var.vpc_network_name
  routing_mode = "GLOBAL"

  subnets = [
    {
        subnet_name   = "-primary"
        subnet_ip     = "pri-subnet-cidr"
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
vpc_network_name =  "gke-vpc"
primary_subnet_cidr = "10.10.0.0/16"
secondary_subnet_cidr_1 = "10.20.0.0/16"
secondary_subnet_cidr_2 = "10.30.0.0/16"
ENABLED_CLOUD_NAT = false


#GKE vars

name = "stateful-app"
zone = "europe-west2"
enable_private_endpoint = false
kubernetes_version = "1.22.12-gke.1200"
  
cluster_zones = [
    "europe-west2-a",
    "europe-west2-b"
  ]
  
node_pools = [
      {
      "name" : "stateful-app",
      "machine_type" : "e2-medium",
      "node_locations" : "europe-west2-a,europe-west2-b,europe-west2-c"
      "disk_type" : "pd-ssd",
      "image_type" : "COS_CONTAINERD",
      "auto_repair" : true,
      "auto_upgrade" : true,
      "initial_node_count" : 1,
      "min_count" : 1,
      "max_count" : 2,
      "enable_integrity_monitoring" : true,
      "enable_secure_boot" : true
      
    }
  ]

  node_pools_oauth_scopes = {
    "ssd8-np" : [
      "https://www.googleapis.com/auth/cloud_debugger",
      "https://www.googleapis.com/auth/monitoring"
    ]
  }

  
 resource "google_compute_address" "router_demo" {
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
