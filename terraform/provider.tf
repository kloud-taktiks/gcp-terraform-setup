provider "google" {
  project = var.project_id
  region  = var.regions[0]
  version = "3.58"
}

provider "google-beta" {
  project = var.project_id
  region  = var.regions[0]
  version = "3.58"
}

terraform {
  required_version = "0.13.6"

  backend "gcs" {
    bucket = "-tfstate"
    prefix = ""
  }
}