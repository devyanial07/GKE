module "gke_stateful" {

    depends_on  = [
        module.vpc_network
    ]
    source = "./gke-stateful"

    #project                    = var.project
    #cluster_name               = var.cluster_name
    #region                     = var.region
    #cluster_zones              = var.cluster_zones
    #network                    = var.vpc_network_name
    #subnetwork                 = "${var.vpc_network_name}-primary"
    #ip_range_pods              = "${var.vpc_network_name}-secondary-1"
    #ip_range_services          = "${var.vpc_network_name}-secondary-2"
    #kubernetes_version         = var.kubernetes_version
}