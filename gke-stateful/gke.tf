data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}


module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version = "21.1.0"
  project_id                 = var.project
  name                       = var.cluster_name
  region                     = var.region
  zones                      = var.cluster_zones
  network                    = var.vpc_network_name
  subnetwork                 = "${var.vpc_network_name}-primary"
  ip_range_pods              = "${var.vpc_network_name}-secondary-1"
  ip_range_services          = "${var.vpc_network_name}-secondary-2"
  http_load_balancing        = true
  network_policy             = true
  horizontal_pod_autoscaling = true
  enable_private_endpoint    = true
  enable_private_nodes       = true
  issue_client_certificate   = false
  remove_default_node_pool   = true
  master_ipv4_cidr_block     = "10.0.0.0/28"
  #kubernetes_version         = var.kubernetes_version
  enable_vertical_pod_autoscaling = true
  grant_registry_access           = true
  enable_binary_authorization     = true
  node_metadata = "GKE_METADATA_SERVER"

  add_master_webhook_firewall_rules = true
  add_cluster_firewall_rules        = true
  add_shadow_firewall_rules         = true
  monitoring_service = "monitoring.googleapis.com/kubernetes"
  logging_service    = "logging.googleapis.com/kubernetes"

  node_pools = [
    {
      name                      = "default-node-pool"
      machine_type              = "e2-medium"
      node_locations            = "europe-west2-a,europe-west2-b,europe-west2-c"
      min_count                 = 1
      max_count                 = 1
      disk_type                 = "pd-standard"
      image_type                = "COS_CONTAINERD"
      auto_repair               = true
      auto_upgrade              = true
      service_account           = "project-service-account@<PROJECT ID>.iam.gserviceaccount.com"
      initial_node_count        = 1
      enable_secure_boot        = true
    },
  ]
  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
  timeouts = {"600"}

}
  
/* 
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
 */