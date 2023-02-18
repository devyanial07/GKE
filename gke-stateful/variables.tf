variable "project" {
  description = "The ID of the Google Cloud project"
}

variable "cluster_name" {}

variable "region" {}

variable "cluster_zones" {}

variable "vpc_network" {}

variable "vpc_subnet" {}

variable "vpc_subnet_pod" {}

variable "vpc_subnet_svc" {}

variable "kubernetes_version" {}