## GKE SA ##

resource "google_service_account" "gke_sa" {
  account_id   = "champ-gke-sa"
  display_name = "Service Account for gke"
}
resource "google_project_iam_member" "gke_role" {
  for_each = toset([
    "roles/cloudsql.admin",
    "roles/secretmanager.secretAccessor",
    "roles/datastore.owner",
    "roles/storage.admin",
    "roles/artifactregistry.admin",
    "roles/container.clusterAdmin",
    "roles/container.developer"
    #"roles/storage.legacyObjectReader"
  ])
  role = each.key
  member = "serviceAccount:${google_service_account.gke_sa.email}"
  project = var.project
}

## GKE instance ##
/* module "gke" {
  depends_on  = [
    module.project_api
  ]
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  #version                    = "21.1.0"
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
  #enable_private_endpoint    = true
  enable_private_nodes       = false
  issue_client_certificate   = false
  remove_default_node_pool   = true
  master_ipv4_cidr_block     = "10.0.0.0/28"
  #kubernetes_version         = "1.18.17-gke.1901"
  enable_vertical_pod_autoscaling = true
  grant_registry_access           = true
  enable_binary_authorization     = true
  node_metadata = "GKE_METADATA_SERVER"
  #master_authorized_networks      = []

  add_master_webhook_firewall_rules = true
  add_cluster_firewall_rules        = true
  add_shadow_firewall_rules         = true
  monitoring_service = "monitoring.googleapis.com/kubernetes"
  logging_service    = "logging.googleapis.com/kubernetes"

  node_pools = [
    {
      name                      = "default-node-pool"
      machine_type              = "e2-medium"
      node_locations            = "europe-west2-a"
      min_count                 = 2
      max_count                 = 4
      disk_type                 = "pd-standard"
      image_type                = "COS_CONTAINERD"
      auto_repair               = true
      auto_upgrade              = true
      service_account           = google_service_account.gke_sa.email
      initial_node_count        = 3
      enable_secure_boot        = true
    },
  ]
  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}  */


/* module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//examples/simple_autopilot_private"

  project_id                      = var.project_id
  name                            = var.cluster_name
  regional                        = true
  region                          = var.region
  network                         = var.vpc_network_name
  subnetwork                      = "${var.vpc_network_name}-primary"
  ip_range_pods                   = "${var.vpc_network_name}-secondary-1"
  ip_range_services               = "${var.vpc_network_name}-secondary-2"
  release_channel                 = "REGULAR"
  enable_vertical_pod_autoscaling = true
  enable_private_endpoint         = true
  enable_private_nodes            = true
  master_ipv4_cidr_block          = "10.0.0.0/28"
  network_tags                    = ["simple-autopilot-private"]

  #master_authorized_networks = [ ]

  node_pools = [
    {
      name                      = "default-node-pool"
      machine_type              = "e2-medium"
      node_locations            = "europe-west2-a"
      min_count                 = 2
      max_count                 = 5
      disk_type                 = "pd-standard"
      image_type                = "COS_CONTAINERD"
      auto_repair               = true
      auto_upgrade              = true
      service_account           = google_service_account.gke_sa.email
      initial_node_count        = 3
      enable_secure_boot        = true
    },
  ]
  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
} */