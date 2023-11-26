terraform {
  required_version = "= 1.3.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.74.0"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.74.0"
    }
  }

  backend "gcs" {
    bucket = "tf-state-training-394392"
    prefix = "001-gclb-cdn-gcs"
  }
}

provider "google" {
  credentials = file("~/.config/gcloud/application_default_credentials.json")
  project     = "training-394302"
  region      = "asia-northeast1"
}

provider "google-beta" {
  credentials = file("~/.config/gcloud/application_default_credentials.json")
  project     = "training-394302"
  region      = "asia-northeast1"
}

