variable "approle_role_id" {
  description = "The role ID for Vault AppRole authentication"
  type        = string
}

variable "approle_secret_id" {
  description = "The secret ID for Vault AppRole authentication"
  type        = string
  sensitive   = true
}
