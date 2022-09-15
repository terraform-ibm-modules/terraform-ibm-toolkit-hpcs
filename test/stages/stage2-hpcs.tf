module "dev_hpcs" {
  source = "./module"

  resource_group_name    = module.resource_group.name
  region                 = var.hpcs_region
  name                   = var.hpcs_name
  name_prefix            = var.name_prefix
  provision              = true
  number_of_crypto_units = 2
}

resource null_resource print_urls {
  provisioner "local-exec" {
    command = "echo -n '${module.dev_hpcs.public_url}' > .public_url"
  }
  provisioner "local-exec" {
    command = "echo -n '${module.dev_hpcs.private_url}' > .private_url"
  }
}
