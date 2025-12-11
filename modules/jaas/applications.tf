# OpenFGA for authorization
resource "juju_application" "openfga" {
  model_uuid = var.model_uuid
  name       = "openfga"
  trust      = true
  units      = var.openfga_units

  charm {
    name    = "openfga-k8s"
    channel = var.openfga_channel
    base    = "ubuntu@22.04"
  }
}

# Vault for secrets management
resource "juju_application" "vault" {
  model_uuid = var.model_uuid
  name       = "vault"
  trust      = true
  units      = var.vault_units

  charm {
    name    = "vault-k8s"
    channel = var.vault_channel
    base    = var.vault_base
  }
}

# Oauth-integrator for OAuth integration
resource "juju_application" "oauth_integrator" {
  model_uuid = var.model_uuid
  name       = "oauth-external-idp-integrator"
  units      = 1

  charm {
    name    = "oauth-external-idp-integrator"
    channel = var.oauth_integrator_channel
    base    = "ubuntu@22.04"
  }

  config = {
    authorization_endpoint = var.oauth_authorization_endpoint
    client_id              = var.oauth_client_id
    client_secret          = var.oauth_client_secret
    issuer_url             = var.oauth_issuer_url
    introspection_endpoint = var.oauth_introspection_endpoint
    jwks_endpoint          = var.oauth_jwks_endpoint
    jwt_access_token       = var.oauth_jwt_access_token
    scope                  = var.oauth_scope
    token_endpoint         = var.oauth_token_endpoint
    userinfo_endpoint      = var.oauth_userinfo_endpoint
  }
}

# TODO: Add ingress and TLS certs (or consume offers)