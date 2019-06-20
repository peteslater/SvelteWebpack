terraform {
  backend "s3" {
    bucket = "terraform-state-svelte"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}

provider "aws" {
  version   = "~> 2.0"
  region    = var.region
}
