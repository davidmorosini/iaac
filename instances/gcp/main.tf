terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "<TERRAFORM_CLOUD_ORGANIZATION>"

    workspaces {
      name = "<TERRAFORM_CLOUD_WORKSPACE>"
    }
  }
}

