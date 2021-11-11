terraform {
  experiments = [module_variable_optional_attrs]
}

resource "google_bigquery_dataset" "dataset" {
  project  = var.dataset.project
  location = var.dataset.location

  dataset_id                 = var.dataset.id
  friendly_name              = var.dataset.name
  description                = var.dataset.description
  labels                     = var.dataset.labels
  delete_contents_on_destroy = var.dataset.delete_contents_on_destroy

  dynamic "access" {
    for_each = concat(
      local.dataset_read_permissions,
      local.dataset_write_permissions,
      local.dataset_owner_permissions
    )
    content {
      role = access.value.role

      domain         = lookup(access.value, "domain", null)
      group_by_email = lookup(access.value, "group_by_email", null)
      user_by_email  = lookup(access.value, "user_by_email", null)
      special_group  = lookup(access.value, "special_group", null)
    }
  }
}

resource "google_bigquery_table" "table" {
  for_each = local.tables

  dataset_id      = google_bigquery_dataset.dataset.dataset_id
  friendly_name   = each.value.id
  table_id        = each.value.id
  labels          = merge(var.dataset.labels, each.value.labels)
  schema          = each.value.schema != null ? file(each.value.schema) : null
  clustering      = each.value.clustering
  expiration_time = null
  project         = var.project

  dynamic "time_partitioning" {
    for_each = each.value.time_partitioning != null ? [each.value.time_partitioning] : []
    content {
      type                     = time_partitioning.value.type
      expiration_ms            = time_partitioning.value.expiration_ms
      field                    = time_partitioning.value.field
      require_partition_filter = time_partitioning.value.require_partition_filter
    }
  }

  dynamic "range_partitioning" {
    for_each = each.value.range_partitioning != null ? [each.value.range_partitioning] : []
    content {
      field = range_partitioning.value.field
      range {
        start    = range_partitioning.value.range.start
        end      = range_partitioning.value.range.end
        interval = range_partitioning.value.range.interval
      }
    }
  }

  dynamic "materialized_view" {
    for_each = each.value.materialized_view != null ? [each.value.materialized_view] : []
    content {
      query               = file(materialized_view.value.query)
      enable_refresh      = materialized_view.value.enable_refresh
      refresh_interval_ms = materialized_view.value.refresh_interval_ms
    }
  }

  dynamic "view" {
    for_each = each.value.view != null ? [each.value.view] : []
    content {
      query          = view.value.query != null ? file(view.value.query) : null
      use_legacy_sql = view.value.use_legacy_sql
    }
  }
}
