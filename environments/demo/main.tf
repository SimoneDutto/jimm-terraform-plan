# JAAS Demo Environment
# This environment uses one module:
# 1. jaas - Deploys the JAAS stack (JIMM, OpenFGA, and supporting services)

locals {
  juju_model_name    = "k8s-dev-jaas-ps7-jaas"
  juju_model_owner   = "admin"
  database_offer_url = "admin/dbaas-dev-jaas-ps7.postgresql"
  jaas_hostname      = "dev-jaas.ps7.internal"
  jimm_uuid          = "40b2d9bd-f432-42a9-bd4b-9b5558bef9da" # pre-generated for stability
  log_level          = "info"
}

data "juju_model" "jaas_model" {
  name  = local.juju_model_name
  owner = local.juju_model_owner
}

data "vault_generic_secret" "jimm_macaroon_keypair" {
  # generated with 'go run github.com/go-macaroon-bakery/macaroon-bakery/cmd/bakery-keygen/v3@latest'
  path = "secret/prodstack7/roles/${local.juju_model_name}/macaroon_keypair"
}

data "vault_generic_secret" "jimm_oauth_cidp" {
  path = "secret/prodstack7/roles/${local.juju_model_name}/oidc/oauth_provider"
}

# JAAS module - Deploys the complete JAAS stack
module "jaas" {
  source = "../../modules/jaas"

  # Model configuration
  model_uuid = data.juju_model.jaas_model.uuid

  # JIMM Charm
  jimm_channel  = "3/edge"
  jimm_units    = 1
  jimm_name     = "jimm"
  jimm_base     = "ubuntu@22.04"
  jimm_revision = 94

  # JIMM configuration
  jimm_uuid        = local.jimm_uuid
  jimm_public_key  = data.vault_generic_secret.jimm_macaroon_keypair.data["public"]
  jimm_private_key = data.vault_generic_secret.jimm_macaroon_keypair.data["private"]
  dns_name         = local.jaas_hostname
  log_level        = local.log_level
  controller_admins = join(" ", [
    "ales.stimec@canonical.com",
    "alexander.kilroy@canonical.com",
    "kian.parvin@canonical.com",
    "luci.branescumihaila@canonical.com",
    "simone.dutto@canonical.com"
  ])


  # OAuth configuration
  oauth_client_id              = data.vault_generic_secret.jimm_oauth_cidp.data["client_id"]
  oauth_client_secret          = data.vault_generic_secret.jimm_oauth_cidp.data["client_secret"]
  oauth_authorization_endpoint = "https://login.canonical.com/oauth2/auth"
  oauth_scope                  = "openid email profile offline_access"
  oauth_issuer_url             = "https://login.canonical.com/k8s-prod-is-cidp-2-iam-2-hydra"
  oauth_jwks_endpoint          = "https://login.canonical.com/.well-known/jwks.json"
  oauth_jwt_access_token       = true
  oauth_token_endpoint         = "https://login.canonical.com/oauth2/token"
  oauth_userinfo_endpoint      = "https://login.canonical.com/userinfo"
  oauth_introspection_endpoint = "https://login.canonical.com/admin/oauth2/introspect" # not a real URL

  # External offers
  postgresql_offer_url = local.database_offer_url
}
