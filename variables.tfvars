project =  "lofty-object-378217"
region  =  "europe-west2"


vpc_network_name    =  "gke-network"
primary_subnet_cidr = "10.10.0.0/16"
secondary_subnet_cidr_1 = "10.20.0.0/16"
secondary_subnet_cidr_2 = "10.30.0.0/16"

#GKE vars

cluster_name = "stateful-gkeapp"
zone = "europe-west2"
enable_private_endpoint = false
kubernetes_version = "1.22.12-gke.1200"
  
cluster_zones = [
    "europe-west2-a",
    "europe-west2-b",
    "europe-west2-c"
]