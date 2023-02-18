project =  "lofty-object-378217"
region  =  "europe-west2"


vpc_network_name    =  "gke-network"
primary_subnet_cidr = "10.10.0.0/16"
secondary_subnet_cidr_1 = "10.20.0.0/16"
secondary_subnet_cidr_2 = "10.30.0.0/16"

#GKE vars

cluster_name = "stateful-app"
zone = "europe-west2"
enable_private_endpoint = false
kubernetes_version = "1.22.12-gke.1200"
  
cluster_zones = [
    "europe-west2-a",
    "europe-west2-b",
    "europe-west2-c"
  ]
  
/* node_pools = [
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
 */