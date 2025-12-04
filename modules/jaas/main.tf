# JAAS Module - Deploys the JAAS stack including JIMM, OpenFGA, and supporting services

# JIMM - deployed using the canonical/jimm-k8s-operator terraform module
module "jimm" {
  source = "git::https://github.com/canonical/jimm-k8s-operator.git//terraform?ref=4dbf3c7daac42f1e2e165b94c57a3a5d5ba5d61a"

  model_uuid = var.model_uuid

  jimm_charm = {
    name     = var.jimm_name
    channel  = var.jimm_channel
    base     = var.jimm_base
    revision = var.jimm_revision
  }
  units = var.jimm_units

  jimm_config = {
    uuid              = var.jimm_uuid
    controller_admins = var.controller_admins
    log_level         = var.log_level
    dns_name          = var.dns_name
    public_key        = var.jimm_public_key
    private_key       = var.jimm_private_key


  }

  postgresql = {
    offer_url = var.postgresql_offer_url
  }

  openfga = {
    application_name = juju_application.openfga.name
  }

  ingress = {
  }

  oauth = {
    application_name = juju_application.oauth_integrator.name
  }

  vault = {  
    application_name = juju_application.vault.name  
  }
}
