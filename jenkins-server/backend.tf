terraform {
  backend "s3" {
    bucket = "mydevopsclass-terraform-state"
    key    = "jenkins/terraform.tfstate"
    region = "ap-southeast-1"
  }
}