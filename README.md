# JAAS Terraform Plan

This repository contains the Terraform plan to deploy [JAAS](https://canonical-jaas-documentation.readthedocs-hosted.com/en/v3/), which includes the JIMM application, OpenFGA, Vault and other supporting services.

## Architecture

The repository is structured with a modular approach:

```
.
├── environments/ # Top-level Terraform plan for deploying JAAS
|   └──demo         # Specific environment we are deploying
│      ├── main.tf           # Main configuration using vault and jaas
│      ├── variables.tf      # Input variables
│      ├── providers.tf      # Configured providers
│      └── version.tf        # Specifies provider versions
├── modules/
│   └── jaas/             # Module for deploying JAAS stack
│       ├── main.tf         # JAAS applications (OpenFGA + other services + JIMM module)
│       ├── integrations.tf # Juju integrations between applications
│       ├── variables.tf    # Input variables
│       └── provider.tf     # Provider requirements
└── README.md
```

### Modules

#### JAAS Module (`modules/jaas`)

The JAAS module deploys the JAAS stack:
- **JIMM** - Juju Intelligent Model Manager (via [canonical/jimm-k8s-operator terraform module](https://github.com/canonical/jimm-k8s-operator/tree/v3/terraform))
- **OpenFGA** - Authorization service
- **Vault** - The Vault used by JIMM to hold credentials
- **Oauth-external-idp-integrator** - Integrates with an external IDP
- Other services eventually for TLS, ingress, etc.

External services consumed via Juju offers:
- **PostgreSQL** - Database (external offer)

## Requirements

- [Terraform](https://www.terraform.io/downloads.html) >= 1.6.0
- [Vault](https://www.vaultproject.io/) instance with secrets configured
- Juju controller with Kubernetes cloud
- [kubectl](https://kubernetes.io/docs/tasks/tools/) configured for your cluster
- External PostgreSQL and Ingress offers already deployed

### Vault Secrets Structure

The following secrets should be configured in Vault:

**Juju Credentials** (at `juju_credentials_path`):
```json
{
  "controller_addresses": "10.0.0.1:17070",
  "username": "admin",
  "password": "your-password",
  "ca_certificate": "-----BEGIN CERTIFICATE-----..."
}
```

**Application Secrets**:
The only application secrets currently are JIMM's macaroon key-pair.
These are expected to be available at `secret/prodstack7/roles/<juju-model-name>/macaroon_keypair`
and contain the following data.

```json
{
  "jimm_public_key": "base64-encoded-public-key",
  "jimm_private_key": "base64-encoded-private-key"
}
```

> **Note**: You can generate JIMM's bakery keypair using:
> ```bash
> go run github.com/go-macaroon-bakery/macaroon-bakery/cmd/bakery-keygen/v3@latest
> ```

## Deploy

1. **Configure Vault access**:
   ```bash
   export TF_VAR_approle_role_id=<approle-id>
   export TF_VAR_approle_secret_id=<approle-secret-id>
   ```

2. **Navigate to the environments directory**:
   ```bash
   cd environments
   cd <desired-env>
   ```

3. **Initialize Terraform**:
   ```bash
   terraform init
   ```

4. **Review the plan**:
   ```bash
   terraform plan
   ```

5. **Apply the configuration**:
   ```bash
   terraform apply
   ```
