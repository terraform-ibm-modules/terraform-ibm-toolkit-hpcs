# HPCS terraform module

Provisions an instance of hpcs in the account.

**Note:** This module follows the Terraform conventions regarding how provider configuration is defined within the Terraform template and passed into the module - https://www.terraform.io/docs/language/modules/develop/providers.html. The default provider configuration flows through to the module. If different configuration is required for a module, it can be explicitly passed in the `providers` block of the module - https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly.


## Example usage

```terraform-hcl
terraform {
  required_providers {
    ibm = {
      source = "ibm-cloud/ibm"
    }
  }
  required_version = ">= 0.13"
}

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region = var.region
}

module "dev_infrastructure_hpcs" {
  source = "github.com/ibm-garage-cloud/terraform-ibm-key-hpcs?ref=v1.0.0"

  resource_group_name = module.dev_cluster.resource_group_name
  resource_location   = module.dev_cluster.region
  cluster_id          = module.dev_cluster.id
  namespaces          = []
  namespace_count     = 0
  name_prefix         = var.name_prefix
  tags                = []
  plan                = "standard"
  service_endpoints      = var.service_endpoints
  number_of_crypto_units = var.number_of_crypto_units
}
```

## Post install steps

Once a Hyper Protect Crypto Service has been provisioned, it must be initialized before it can be used. Currently, the initialization process must be performed manually. The following steps must be followed to complete the initialization - https://cloud.ibm.com/docs/hs-crypto?topic=hs-crypto-initialize-hsm
