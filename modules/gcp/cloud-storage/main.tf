resource "google_storage_bucket" "bucket_application" {
  name = var.use_only_name == true ? var.name : format(
    "%s-%s-%s",
    var.name,
    var.project,
    var.region,
  )

  project       = var.project
  location      = var.region
  storage_class = var.storage_class
  force_destroy = var.force_destroy
  labels        = var.labels

  versioning {
    enabled = var.enable_versioning
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_data_days != null ? [var.lifecycle_data_days] : []
    content {
      action {
        type = "Delete"
      }
      condition {
        age = lifecycle_rule.value
      }
    }
  }

}
