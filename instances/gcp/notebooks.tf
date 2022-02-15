data "google_compute_network" "network-notebooks" {
  name    = "<NETWORK-NAME>"
  project = "<NETWORK-PROJECT>"
}


data "google_compute_subnetwork" "subnet-notebooks" {
  name    = "<SUBNET-NAME>"
  region  = "us-east1"
  project = "<NETWORK-PROJECT>"
}


locals {
  notebooks = {
    default = {
      location = "us-east1-b"
      # 4 vCPU 4 GB RAM
      machine_type       = "e2-highcpu-4"
      vm_image_project   = "deeplearning-platform-release"
      image_family       = "tf-latest-cpu"
      service_account    = "<SERVICE-ACCOUNT>@<PROJECT-ID>.iam.gserviceaccount.com"
      install_gpu_driver = false
      boot_disk_type     = "PD_SSD"
      boot_disk_size     = 50 # GB
      network            = data.google_compute_network.network-notebooks.id
      subnet             = data.google_compute_subnetwork.subnet-notebooks.id
      no_public_ip       = true
      no_proxy_access    = false
      metadata = {
        proxy-mode = "service_account"
        terraform  = "true"
      }
    }
    instances = [
      {
        id = "risk-notebook-low-1"
      }
    ]
  }
}


module "notebooks-risk" {
  source    = "../../modules/gcp/jupyter-notebook"
  project   = "<PROJECT-ID>"
  notebooks = local.notebooks
}
