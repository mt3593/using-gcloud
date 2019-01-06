provider "google" {
  region = "europe-west1"
  project = "my-first-project-227809" # Edit to your own project id
  version = "~> 1.12.0"
}

provider "null" {
  version = "~> 1.0"
}

terraform {
  backend "gcs" {
    bucket = "mtinsley-terraform-state" # Edit to your bucket name
    prefix = "cluster"
  }
}

module "cluster" {
  source = "modules"
  cluster_name = "${terraform.workspace}"
}
