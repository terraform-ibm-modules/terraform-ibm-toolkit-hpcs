# HPCS terraform module

Provisions an instance of hpcs in the account.

## Example usage

```terraform-hcl
module "dev_infrastructure_hpcs" {
  # source = "github.com/ibm-garage-cloud/terraform-ibm-key-hpcs?ref=v1.0.0"
  source = "github.com/slzone/terraform-ibm-hpcs"
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

### Download JsonFile From COS
```hcl
module "download_from_cos" {
  source          = "github.com/slzone/terraform-ibm-hpcs/modules/ibm-hpcs-initialisation/download-from-cos"
  api_key         = var.api_key
  cos_crn         = var.cos_crn
  endpoint        = var.endpoint
  bucket_name     = var.bucket_name
  input_file_name = var.input_file_name
}
```
### Initialise HPCS instance using json file
```hcl

module "hpcs_init" {
  source             = "github.com/slzone/terraform-ibm-hpcs/modules/ibm-hpcs-initialisation/hpcs-init"
  depends_on         = [module.download_from_cos]
  tke_files_path     = var.tke_files_path
  input_file_name    = var.input_file_name
  hpcs_instance_guid = data.ibm_resource_instance.hpcs_instance.guid
}

```
### Upload TKE Files to COS
```hcl
module "upload_to_cos" {
  source             = "github.com/slzone/terraform-ibm-hpcs/modules/ibm-hpcs-initialisation/upload-to-cos"
  depends_on         = [module.hpcs_init]
  api_key            = var.api_key
  cos_crn            = var.cos_crn
  endpoint           = var.endpoint
  bucket_name        = var.bucket_name
  tke_files_path     = var.tke_files_path
  hpcs_instance_guid = data.ibm_resource_instance.hpcs_instance.guid
}
```
### Remove TKE Files from local machine
`Note:` This module will remove TKE files without having backup.. It is advisable to use this module after uploading TKE Files to COS

```hcl
module "remove_tke_files" {
  source             = "github.com/slzone/terraform-ibm-hpcs/modules/ibm-hpcs-initialisation/remove-tkefiles"
  depends_on         = [module.upload_to_cos]
  tke_files_path     = var.tke_files_path
  input_file_name    = var.input_file_name
  hpcs_instance_guid = data.ibm_resource_instance.hpcs_instance.guid
}
```
`

### TBD
__Add Attribution to IBM official terraform module code for HPCS initialization__
__Check existing Post install steps pointing to manual steps to change language and location of where this block of info goes__

## Post install steps

Once a Hyper Protect Crypto Service has been provisioned, it must be initialized before it can be used. Currently, the initialization process must be performed manually. The following steps must be followed to complete the initialization - https://cloud.ibm.com/docs/hs-crypto?topic=hs-crypto-initialize-hsm
