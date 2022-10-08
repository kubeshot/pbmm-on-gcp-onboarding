
terraform {
  backend "gcs" {
    bucket = "lzpeksnonprodbucket"
    prefix = "environments/nonprod"
  }
}

data "terraform_remote_state" "bootstrap" {
    backend = "gcs"
    config = {
      bucket = "lzpekscommonbckt"
      prefix = "environments/bootstrap"
    }  
}

data "terraform_remote_state" "common" {
    backend = "gcs"
    config = {
      bucket = "lzpekscommonbckt"
      prefix = "environments/common"
    }
}

