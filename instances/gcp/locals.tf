locals {

  gcp_project_id     = "<PROJECT_ID>"
  gcp_default_sa     = "<SERVICE_ACCOUNT_NAME>@<PROJECT_ID>.iam.gserviceaccount.com"
  gcp_default_region = "us-east1"
  environment        = "production"
  base_tags          = { "env" : local.environment, "team" : "<TEAM_NAME>" }

}
