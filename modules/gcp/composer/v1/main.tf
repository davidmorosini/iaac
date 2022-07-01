resource "google_composer_environment" "composer_cluster" {
  name    = var.composer_name
  region  = var.region
  project = var.project

  config {
    node_count = var.composer_node_count

    node_config {
      zone            = var.composer_zone
      machine_type    = var.composer_machine_type
      network         = var.composer_network
      subnetwork      = var.composer_subnetwork
      disk_size_gb    = var.composer_disk_size_gb
      oauth_scopes    = var.oauth_scopes
      service_account = var.composer_service_account
      tags            = var.composer_tags

      ip_allocation_policy {
        use_ip_aliases                = true
        services_secondary_range_name = var.services_name
        cluster_secondary_range_name  = var.pods_name
      }
    }

    software_config {
      image_version            = var.composer_image_version
      python_version           = var.composer_python_version
      pypi_packages            = var.pypi_packages
      env_variables            = var.env_variables
      airflow_config_overrides = var.airflow_config_overrides
    }

    private_environment_config {
      enable_private_endpoint = true
    }
  }

  timeouts {
    create = var.timeout_create
    update = var.timeout_update
    delete = var.timeout_delete
  }
}
