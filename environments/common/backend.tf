terraform {
  backend "gcs" {
    bucket = "lzpekscommonbckt"
    prefix = "environments/common"
  }
}
data "terraform_remote_state" "bootstrap" {
    backend = "gcs"
    config = {
      bucket = "lzpekscommonbckt"
      prefix = "environments/bootstrap"
    }  
}
