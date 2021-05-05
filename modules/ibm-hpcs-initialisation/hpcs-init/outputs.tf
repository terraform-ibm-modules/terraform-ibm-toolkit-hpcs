#########################################################################################
# IBM Cloud Hyper Protect Crypto Services Provisioning, Initialization and Managing Keys
# Copyright 2020 IBM
#########################################################################################
output "hpcs_init" {
  value = var.initialize == false ? null : format("%v", null_resource.hpcs_init.*.id)
}
