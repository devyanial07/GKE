module "gke_stateful" {
  depends_on  = [
        module.vpc_network
    ]
  source                     = "./gke-stateful"
}