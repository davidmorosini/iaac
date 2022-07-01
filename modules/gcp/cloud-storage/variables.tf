variable "name" {}
variable "project" {}
variable "region" {}

# Variables with default value
variable "lifecycle_data_days" {
  default = null
}
variable "enable_versioning" {
  default = false
}
variable "storage_class" {
  default = "STANDARD"
}
variable "use_only_name" {
  default = false
}
variable "force_destroy" {
  default = false
}

variable "labels" {
  default = {}
}
