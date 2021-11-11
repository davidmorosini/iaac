terraform {
  required_version = "~> 1.0"
  required_providers {
    google      = "~> 3.0"
    google-beta = "~> 3.0"
    local       = "= 2.0.0"
    random      = "= 2.3.0"
    template    = "= 2.1.2"
  }
}
