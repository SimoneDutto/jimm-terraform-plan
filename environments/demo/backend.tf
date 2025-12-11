terraform {
  backend "s3" {
    endpoints = {
      s3 = "https://radosgw.ps7.canonical.com"
    }
    bucket                      = "k8s-dev-jaas-ps7-jaas-tfstate"
    region                      = "prodstack7"
    key                         = "state"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    use_path_style              = true
  }
}
