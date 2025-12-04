# Integrate OpenFGA with PostgreSQL
resource "juju_integration" "openfga_postgresql" {
  model_uuid = var.model_uuid
  application {
    name = juju_application.openfga.name
  }
  application {
    offer_url = var.postgresql_offer_url
  }
}

# TODO: Integrate ingress with TLS certificates
