variable "dataset" {
  type = object({
    project                    = string
    location                   = string
    id                         = string
    name                       = string
    description                = string
    delete_contents_on_destroy = bool
    labels                     = map(string)
    read_permissions           = list(string)
    write_permissions          = list(string)
    owner_permissions          = list(string)
    tables = list(object({
      id         = string
      schema     = optional(string)
      labels     = optional(map(string))
      clustering = optional(list(string))
      time_partitioning = optional(object({
        type                     = string
        field                    = string
        require_partition_filter = bool
        expiration_ms            = number
      }))
      range_partitioning = optional(object({
        field = string
        range = object({
          start    = number
          end      = number
          interval = number
        })
      }))
      materialized_view = optional(object({
        query               = string
        enable_refresh      = bool
        refresh_interval_ms = number
      }))
      view = optional(object({
        query          = string
        use_legacy_sql = bool
      }))
    }))
  })
  description = "Dataset Attributes"
}
