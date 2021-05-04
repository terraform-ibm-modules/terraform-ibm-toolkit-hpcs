# Enable the HPCS policies 

data "ibm_resource_group" "rg_name" {
  name = var.resource_group_name
}

data "ibm_resource_instance" "hpcs_instance" {
  name              = var.service_name
  resource_group_id = data.ibm_resource_group.rg_name.id
  service           = var.service_name
}

resource "null_resource" "enable_policies" {
  provisioner "local-exec" {
    when    = create
    command = "/bin/bash scripts/network_policy.sh"

    environment = {
      REGION               = var.region
      HPCS_INSTANCE_ID     = data.ibm_resource_instance.hpcs_instance.guid
      ALLOWED_NETWORK_TYPE = var.allowed_network_type
      PORT                 = var.hpcs_port
    }
  }
  provisioner "local-exec" {
    when    = create
    command = "/bin/bash scripts/dual_authorization_policy.sh"

    environment = {
      REGION           = var.region
      HPCS_INSTANCE_ID = data.ibm_resource_instance.hpcs_instance.guid
      DUAL_AUTH_DELETE = var.dual_auth_delete
      PORT             = var.hpcs_port
    }
  }
}
