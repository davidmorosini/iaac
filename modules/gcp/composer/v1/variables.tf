variable "composer_name" {}
variable "region" {}
variable "composer_node_count" {}
variable "project" {}

# node_config block.
variable "composer_zone" {}
variable "composer_machine_type" {}
variable "composer_network" {}
variable "composer_subnetwork" {}
variable "composer_disk_size_gb" {}
variable "oauth_scopes" {
  default = null
}
variable "composer_service_account" {}
variable "composer_tags" {
  default = []
}

# software_config block.
variable "composer_image_version" {}
variable "composer_python_version" {}
variable "pypi_packages" {
  default = {}
}
variable "env_variables" {}
variable "airflow_config_overrides" {}

# timeouts
variable "timeout_create" {
  default = "2h"
}
variable "timeout_update" {
  default = "2h"
}
variable "timeout_delete" {
  default = "2h"
}

# gke secondary ip ranges
variable "services_name" {
  description = "CIDR used to create gke services (pre-created vpc secondary ip range)."
}
variable "pods_name" {
  description = "CIDR used to create gke pods (pre-created vpc secondary ip range)."
}
