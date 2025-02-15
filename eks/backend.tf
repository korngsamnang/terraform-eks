terraform {
  backend "s3" {
    bucket = "mydevopsclass-terraform-state"
    key    = "eks/terraform.tfstate"
    region = "ap-southeast-1"
  }
}
