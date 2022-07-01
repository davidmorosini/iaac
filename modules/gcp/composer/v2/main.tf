terraform {
  experiments = [module_variable_optional_attrs]
}

resource "google_composer_environment" "composer_cluster" {
  name    = var.composer_name
  region  = var.region
  project = var.project

  config {
    node_config {
      network         = var.composer_network
      subnetwork      = var.composer_subnetwork
      service_account = var.composer_service_account
      # ip_allocation_policy = var.ip_allocation_policy
    }

    software_config {
      airflow_config_overrides = var.airflow_config_overrides
      pypi_packages            = var.pypi_packages
      env_variables            = var.env_variables
      image_version            = var.composer_image_version
    }

    private_environment_config {
      enable_private_endpoint   = var.enable_private_endpoint
      master_ipv4_cidr_block    = var.master_ipv4_cidr_block
      cloud_sql_ipv4_cidr_block = var.cloud_sql_ipv4_cidr_block
    }

    workloads_config {
      scheduler {
        cpu        = var.scheduler.cpu_number
        memory_gb  = var.scheduler.memory_gb
        storage_gb = var.scheduler.storage_gb
        count      = var.scheduler.replicas
      }
      web_server {
        cpu        = var.webserver.cpu_number
        memory_gb  = var.webserver.memory_gb
        storage_gb = var.webserver.memory_gb
      }
      worker {
        cpu        = var.worker.cpu_number
        memory_gb  = var.worker.memory_gb
        storage_gb = var.worker.storage_gb
        min_count  = var.worker.min_replicas
        max_count  = var.worker.max_replicas
      }
    }
  }

  timeouts {
    create = var.timeout_create
    update = var.timeout_update
    delete = var.timeout_delete
  }
}
