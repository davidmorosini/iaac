terraform {
  experiments = [module_variable_optional_attrs]
}

locals {
  notebooks = { for notebook in var.notebooks.instances : notebook.id => notebook }
}

resource "google_notebooks_instance" "instances" {
  for_each = local.notebooks

  provider     = google-beta
  project      = var.project
  name         = each.value.id
  location     = each.value.location != null ? each.value.location : var.notebooks.default.location
  machine_type = each.value.machine_type != null ? each.value.machine_type : var.notebooks.default.machine_type

  vm_image {
    project      = each.value.vm_image_project != null ? each.value.vm_image_project : var.notebooks.default.vm_image_project
    image_family = each.value.image_family != null ? each.value.image_family : var.notebooks.default.image_family
  }

  service_account    = each.value.service_account != null ? each.value.service_account : var.notebooks.default.service_account
  install_gpu_driver = each.value.install_gpu_driver != null ? each.value.install_gpu_driver : var.notebooks.default.install_gpu_driver
  boot_disk_type     = each.value.boot_disk_type != null ? each.value.boot_disk_type : var.notebooks.default.boot_disk_type
  boot_disk_size_gb  = each.value.boot_disk_size != null ? each.value.boot_disk_size : var.notebooks.default.boot_disk_size
  no_public_ip       = each.value.no_public_ip != null ? each.value.no_public_ip : var.notebooks.default.no_public_ip
  no_proxy_access    = each.value.no_proxy_access != null ? each.value.no_proxy_access : var.notebooks.default.no_proxy_access
  network            = each.value.network != null ? each.value.network : var.notebooks.default.network
  subnet             = each.value.subnet != null ? each.value.subnet : var.notebooks.default.subnet
  metadata           = each.value.metadata != null ? each.value.metadata : var.notebooks.default.metadata

}
