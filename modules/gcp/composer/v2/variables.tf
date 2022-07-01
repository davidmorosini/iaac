variable "composer_name" {}
variable "region" {}
variable "project" {}

# Timeouts block
variable "timeout_create" {
  default = "2h"
}
variable "timeout_update" {
  default = "2h"
}
variable "timeout_delete" {
  default = "2h"
}

# node_config block.
variable "composer_network" {
  description = "The Compute Engine network to be used for machine communications."
}

variable "composer_subnetwork" {
  description = "The Compute Engine subnetwork to be used for machine communications."
}

variable "composer_service_account" {
  type        = string
  description = "The Google Cloud Platform Service Account to be used by the node VMs."
  default     = null
}

# variable "ip_allocation_policy" {
#   type = object({
#     cluster_secondary_range_name  = optional(string)
#     services_secondary_range_name = optional(string)
#     cluster_ipv4_cidr_block       = optional(string)
#     services_ipv4_cidr_block      = optional(string)
#   })
# }

# software_config block.
variable "airflow_config_overrides" {
  description = "Apache Airflow configuration properties to override."
}

variable "pypi_packages" {
  description = "Custom Python Package Index (PyPI) packages to be installed in the environment."
  default     = {}
}

variable "env_variables" {
  description = "Additional environment variables to provide to the Apache Airflow scheduler, worker, and webserver processes."
  default     = {}
}

variable "composer_image_version" {
  description = "The version of the software running in the environment."
}


# private_environment_config block
variable "enable_private_endpoint" {
  type        = bool
  description = "If true, access to the public endpoint of the GKE cluster is denied."
  default     = false
}

variable "master_ipv4_cidr_block" {
  type        = string
  description = "The IP range in CIDR notation to use for the hosted master network."
  default     = null
}

variable "cloud_sql_ipv4_cidr_block" {
  type        = string
  description = "The CIDR block from which IP range in tenant project will be reserved for Cloud SQL."
  default     = null
}

# workloads_config block
variable "scheduler" {
  description = "Configuration for resources used by Airflow schedulers."
  type = object({
    cpu_number = number
    memory_gb  = number
    storage_gb = number
    replicas   = number
  })
  default = {
    cpu_number = 1
    memory_gb  = 1.875
    replicas   = 1
    storage_gb = 10
  }
}

variable "webserver" {
  description = "Configuration for resources used by Airflow web server."
  type = object({
    cpu_number = number
    memory_gb  = number
    storage_gb = number
  })
  default = {
    cpu_number = 1
    memory_gb  = 1.875
    storage_gb = 5
  }
}

variable "worker" {
  description = "Configuration for resources used by Airflow workers."
  type = object({
    cpu_number   = number
    memory_gb    = number
    storage_gb   = number
    min_replicas = number
    max_replicas = number
  })
  default = {
    cpu_number   = 1
    max_replicas = 2
    memory_gb    = 1.875
    min_replicas = 1
    storage_gb   = 1
  }
}