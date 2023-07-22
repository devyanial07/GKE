variable "project" {
  description = "The ID of the Google Cloud project"
}

variable "region" {}

### VPC

variable "vpc_network_name" {}

variable "primary_subnet_cidr" {}

variable "secondary_subnet_cidr_1" {}

variable "secondary_subnet_cidr_2" {}


### GKE

variable "kubernetes_version" {}

variable "cluster_name" {}

variable "cluster_zones" {}

variable "timeouts" {
  type        = map(string)
  description = "Timeout for cluster operations."
  default     = {}
}

variable "MYSQL_DATABASE" {}

variable "MYSQL_PASSWORD" {}

variable "MYSQL_USERNAME" {}