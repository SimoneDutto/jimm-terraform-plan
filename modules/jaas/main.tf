# JAAS Module - Deploys the JAAS stack including JIMM, OpenFGA, and supporting services

# JIMM - deployed using the canonical/jimm-k8s-operator terraform module
module "jimm" {
  source = "git::https://github.com/canonical/jimm-k8s-operator.git//terraform?ref=47b39c5636af3d4542a523dfc9d272d15fde7458"

  model_uuid = var.model_uuid

  name = "jimm"

  jimm_charm = {
    name     = "juju-jimm-k8s"
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
