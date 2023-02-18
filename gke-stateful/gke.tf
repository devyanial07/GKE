
data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

resource "google_service_account" "service_account" {
  account_id   = "test-sa"
  display_name = "test sa"
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                 = var.project
  name                       = var.cluster_name
  region                     = var.region
  zones                      = var.zones
  network                    = var.vpc_network
  subnetwork                 = var.vpc_subnet
  ip_range_pods              = var.vpc_subnet_pod
  ip_range_services          = var.vpc_subnet_svc
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  enable_private_endpoint    = true
  enable_private_nodes       = true
  master_ipv4_cidr_block     = "10.0.0.0/28"

  node_pools = [
    {
      name                      = "default-node-pool"
      machine_type              = "e2-medium"
      node_locations            = "us-central1-b,us-central1-c"
      min_count                 = 1
      max_count                 = 100
      local_ssd_count           = 0
      spot                      = false
      disk_size_gb              = 100
      disk_type                 = "pd-standard"
      image_type                = "COS_CONTAINERD"
      enable_gcfs               = false
      enable_gvnic              = false
      auto_repair               = true
      auto_upgrade              = true
      service_account           = "project-service-account@<PROJECT ID>.iam.gserviceaccount.com"
      preemptible               = false
      initial_node_count        = 80
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }


}
  

module "gke" {
  depends_on = [
    google_project_iam_member.google_apis_service_agent
    ]

  source  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
   version = "21.1.0"
  
  project_id                      = var.project_id
  name                            = var.cluster_name
  region                          = var.location
  zones                           = var.cluster_zones
  network                         = var.cluster_network
  subnetwork                      = var.cluster_subnetwork
  ip_range_pods                   = var.cluster_ip_range_pods
  ip_range_services               = var.cluster_ip_range_svc
  release_channel                 = var.release_channel
  cluster_resource_labels         = var.cluster_resource_labels
  identity_namespace              = var.identity_namespace
  network_policy                  = var.network_policy
  service_account                 = google_service_account.gke_sa.email
  http_load_balancing             = true
  horizontal_pod_autoscaling      = true
  enable_private_endpoint         = var.enable_private_endpoint
  enable_private_nodes            = true
  enable_binary_authorization     = true
  issue_client_certificate        = false
  remove_default_node_pool        = true
  kubernetes_version              = var.kubernetes_version
  enable_vertical_pod_autoscaling = true
  grant_registry_access           = true
  master_authorized_networks      = var.master_authorized_networks
  upstream_nameservers = []

  node_metadata = "GKE_METADATA_SERVER"

  add_master_webhook_firewall_rules = true
  add_cluster_firewall_rules        = true
  add_shadow_firewall_rules         = true


  master_ipv4_cidr_block = var.master_ipv4_cidr_block

  node_pools              = var.node_pools
  node_pools_oauth_scopes = var.node_pools_oauth_scopes
  

  monitoring_service = "monitoring.googleapis.com/kubernetes"
  logging_service    = "logging.googleapis.com/kubernetes"
}
