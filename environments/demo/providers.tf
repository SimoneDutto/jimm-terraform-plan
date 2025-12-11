provider "vault" {
  address = "https://vault.admin.canonical.com:8200"
  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id   = var.approle_role_id
      secret_id = var.approle_secret_id
    }
  }
}

data "vault_generic_secret" "juju_credentials" {
  path = "secret/prodstack7/roles/${local.juju_model_name}/juju"
}

data "vault_generic_secret" "juju_controller_certificate" {
  path = "secret/prodstack7/juju/common/ca_certs/juju-controller-36-cloud-infrastructure-ps7"
}

data "vault_generic_secret" "juju_controller_addresses" {
  path = "secret/prodstack7/juju/common/controllers/juju-controller-36-cloud-infrastructure-ps7"
}

provider "juju" {
  controller_addresses = join(",", formatlist("%s:17070", split(",", data.vault_generic_secret.juju_controller_addresses.data["addresses"])))
  ca_certificate       = data.vault_generic_secret.juju_controller_certificate.data["ca_cert"]
  username             = data.vault_generic_secret.juju_credentials.data["username"]
  password             = data.vault_generic_secret.juju_credentials.data["password"]
}
