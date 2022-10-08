terraform {
  backend "gcs" {
    bucket = "lzpekscommonbckt"
    prefix = "environments/bootstrap"
  }
}
