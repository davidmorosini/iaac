variable "project" {}

variable "notebooks" {
  type = object({
    default = object({
      location           = string
      machine_type       = string
      vm_image_project   = string
      image_family       = string
      service_account    = string
      install_gpu_driver = bool
      boot_disk_type     = string
      boot_disk_size     = number
      network            = string
      subnet             = string
      no_public_ip       = bool
      no_proxy_access    = bool
      metadata           = optional(map(string))
    })
    instances = list(object({
      id                 = string
      location           = optional(string)
      machine_type       = optional(string)
      vm_image_project   = optional(string)
      image_family       = optional(string)
      instance_owners    = optional(string)
      service_account    = optional(string)
      install_gpu_driver = optional(bool)
      boot_disk_type     = optional(string)
      boot_disk_size     = optional(number)
      network            = optional(string)
      subnet             = optional(string)
      no_public_ip       = optional(bool)
      no_proxy_access    = optional(bool)
      metadata           = optional(map(string))
    }))
  })
}
