terraform {
  required_version = ">= 0.13.1"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.71"
    }
  }
}

provider "google" {
#  project = var.project_id
  region  = var.region
}
