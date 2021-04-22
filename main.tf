
resource null_resource print_names {
  provisioner "local-exec" {
    command = "echo 'Resource group: ${var.resource_group_name}'"
  }
}

data "ibm_resource_group" "resource_group" {
  depends_on = [null_resource.print_names]

  name = var.resource_group_name
}

locals {
  name_prefix = var.name_prefix != "" ? var.name_prefix : var.resource_group_name
  name        = var.name != "" ? var.name : "${replace(local.name_prefix, "/[^a-zA-Z0-9_\\-\\.]/", "")}-${var.label}"
  module_path = substr(path.module, 0, 1) == "/" ? path.module : "./${path.module}"
  service_endpoints = var.private_endpoint == "true" ? "private" : "public"
  service     = "hs-crypto"
}

resource "ibm_resource_instance" "hpcs_instance" {
  count = var.provision ? 1 : 0

  name              = local.name
  service           = local.service
  plan              = var.plan
  location          = var.region
  resource_group_id = data.ibm_resource_group.resource_group.id
  tags              = var.tags

  parameters = {
    service-endpoints = local.service_endpoints
    units = var.number_of_crypto_units
  }

  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}


data "ibm_resource_instance" "hpcs_instance" {
  depends_on        = [ibm_resource_instance.hpcs_instance]

  name              = local.name
  resource_group_id = data.ibm_resource_group.resource_group.id
  location          = var.region
  service           = local.service
}
