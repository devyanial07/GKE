module "vpc_network" {
  depends_on  = [
    module.project_api
  ]
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
