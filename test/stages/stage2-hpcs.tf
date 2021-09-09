module "dev_hpcs" {
  source = "./module"

  resource_group_name    = module.resource_group.name
  region                 = var.hpcs_region
  name                   = var.hpcs_name
  name_prefix            = var.name_prefix
  provision              = false
  ibmcloud_api_key       = var.ibmcloud_api_key
  number_of_crypto_units = 2
}
