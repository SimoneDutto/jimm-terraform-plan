# Model configuration
variable "model_uuid" {
  description = "UUID of the Juju model for JAAS deployment"
  type        = string
}

# JIMM configuration
variable "jimm_name" {
  description = "Name of the JIMM application"
  type        = string
  default     = "jimm"
}

variable "jimm_units" {
  description = "Number of JIMM units"
  type        = number
  default     = 1
}

variable "jimm_channel" {
  description = "Charm channel for JIMM"
  type        = string
  default     = "3/stable"
}

variable "jimm_base" {
  description = "Charm base for JIMM"
  type        = string
  default     = "ubuntu@22.04"
}

variable "jimm_revision" {
  description = "Charm revision for JIMM"
  type        = number
}

variable "jimm_uuid" {
  description = "UUID for JIMM controller."
  type        = string
}

variable "controller_admins" {
  description = "Space separated list of users/groups that are made controller admins by default"
  type        = string
  default     = ""
}

variable "log_level" {
  description = "Log level for JIMM (debug, info, warn, error, dpanic, panic, fatal)"
  type        = string
  default     = "info"
}

variable "dns_name" {
  description = "DNS hostname that JIMM is being served from"
  type        = string
}

variable "jimm_public_key" {
  description = "The public part of JIMM's macaroon bakery keypair"
  type        = string
  default     = ""
}

variable "jimm_private_key" {
  description = "The private part of JIMM's macaroon bakery keypair"
  type        = string
  sensitive   = true
  default     = ""
}

# Vault configuration
variable "vault_units" {
  description = "Number of Vault units"
  type        = number
  default     = 1
}

variable "vault_channel" {
  description = "Charm channel for Vault"
  type        = string
  default     = "1.18/stable"
}

# OAuth configuration
variable "oauth_client_id" {
  description = "OAuth client ID"
  type        = string
}

variable "oauth_client_secret" {
  description = "OAuth client secret"
  type        = string
  sensitive   = true
}

variable "oauth_issuer_url" {
  description = "OAuth issuer URL"
  type        = string
}

variable "oauth_authorization_endpoint" {
  description = "OAuth authorization endpoint"
  type        = string
}

variable "oauth_introspection_endpoint" {
  description = "OAuth introspection endpoint"
  type        = string
}

variable "oauth_jwks_endpoint" {
  description = "OAuth JWKS endpoint"
  type        = string
}

variable "oauth_token_endpoint" {
  description = "OAuth token endpoint"
  type        = string
}

variable "oauth_userinfo_endpoint" {
  description = "OAuth userinfo endpoint"
  type        = string
}

variable "oauth_scope" {
  description = "OAuth scope"
  type        = string
  default     = "openid profile email"
}

variable "oauth_jwt_access_token" {
  description = "Whether to use JWT access tokens"
  type        = bool
  default     = true
}

variable "oauth_integrator_channel" {
  description = "Charm channel for OAuth External IDP Integrator"
  type        = string
  default     = "latest/edge"
}

# OpenFGA configuration
variable "openfga_units" {
  description = "Number of OpenFGA units"
  type        = number
  default     = 1
}

variable "openfga_channel" {
  description = "Charm channel for OpenFGA"
  type        = string
  default     = "latest/stable"
}

variable "postgresql_offer_url" {
  description = "Offer URL for external PostgreSQL database"
  type        = string
}
