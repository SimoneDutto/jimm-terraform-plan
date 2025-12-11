# Demo Environment

This environment deploys a demo environment of JAAS.

## Necessary environment variables

The following environment variables must be supplied when running the plan:
- TF_VAR_approle_role_id: used to authenticate with Vault.
- TF_VAR_approle_secret_id: used to authenicate with Vault.
- AWS_ACCESS_KEY_ID: used to authenticate with Openstack Swift for state storage.
- AWS_SECRET_ACCESS_KEY: used to authenticate with Openstack Swift for state storage.

## TODO:
- Setup ingress
- Setup TLS certificates

