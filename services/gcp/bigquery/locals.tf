locals {
  tables = { for table in var.dataset.tables : table.id => table }
  dataset_read_permissions = [for email in var.dataset.read_permissions : {
    "role"          = "READER"
    "user_by_email" = email
    }
  ]
  dataset_write_permissions = [for email in var.dataset.write_permissions : {
    "role"          = "WRITER"
    "user_by_email" = email
    }
  ]
  dataset_owner_permissions = [for email in var.dataset.owner_permissions : {
    "role"          = "OWNER"
    "user_by_email" = email
    }
  ]
}
