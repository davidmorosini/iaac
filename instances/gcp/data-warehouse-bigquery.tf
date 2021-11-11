
locals {
  default_datasets_labels = merge(local.base_tags, {})

  dataset_warehouse_read_emails = [
    local.gcp_default_sa,
    "david.morosini@domain.com"
  ]

  dataset_warehouse_write_emails = [
    local.gcp_default_sa,
    "david.morosini@domain.com"

  ]

  dataset_warehouse_owner_emails = [
    local.gcp_default_sa,
    "david.morosini@domain.com"

  ]

  dataset_warehouse = {
    project                    = local.gcp_project_id
    location                   = "US"
    id                         = "warehouse"
    name                       = "warehouse"
    description                = "Data Warehouse"
    delete_contents_on_destroy = false
    labels                     = local.default_datasets_labels
    read_permissions           = local.dataset_warehouse_read_emails
    write_permissions          = local.dataset_warehouse_write_emails
    owner_permissions          = local.dataset_warehouse_owner_emails

    tables = [
      {
        id     = "dim_payment_method",
        schema = "./assets/warehouse/schemas/dim_payment_method.json",
        range_partitioning = {
          field = "_id",
          range = {
            start    = 1000,
            end      = 2000,
            interval = 100
          }
        },
      },
      {
        id     = "dim_date",
        schema = "./assets/warehouse/schemas/dim_date.json",
        time_partitioning = {
          type                     = "MONTH",
          field                    = "_id",
          require_partition_filter = false,
          expiration_ms            = null,
        },
      },
      {
        id = "dim_seller",
        view = {
          query          = "./assets/warehouse/views/dim_seller.sql",
          use_legacy_sql = false
        }
      },
    ]
  }
}

module "bigquery-datawarehouse" {

  source  = "../services/gcp/bigquery/"
  dataset = local.dataset_warehouse

}
