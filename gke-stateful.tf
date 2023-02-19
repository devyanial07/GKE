/* module "gke_stateful" {
  /* depends_on  = [
        module.vpc_network
    ] 
  source                 = "./gke-stateful"
  project                = var.project
  region                 = var.region
  cluster_zones          = var.cluster_zones
  cluster_name           = var.cluster_name
  vpc_network_name       = var.vpc_network_name
  vpc_network            = var.vpc_network_name
  vpc_subnet             = "${var.vpc_network_name}-primary"
  vpc_subnet_pod         = "${var.vpc_network_name}-secondary-1"
  vpc_subnet_svc         = "${var.vpc_network_name}-secondary-2"
  kubernetes_version     = var.kubernetes_version
} */