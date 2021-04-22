variable "ibmcloud_api_key" {
  type        = string
  description = "The api key for IBM Cloud access"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group where the cluster has been provisioned."
}

variable "name_prefix" {
  type        = string
  description = "The prefix name for the service. If not provided it will default to the resource group name"
  default     = ""
}

variable "region" {
  type        = string
  description = "Geographic location of the resource (e.g. us-south, us-east)"
}

variable "plan" {
  type        = string
  description = "The type of plan the service instance should run under (tiered-pricing)"
  default     = "standard"
}

variable "private_endpoint" {
  type        = string
  description = "Flag indicating that the service should be created with private endpoints"
  default     = "true"
}

variable "tags" {
  type        = list(string)
  description = "Tags that should be applied to the service"
  default     = []
}

variable "number_of_crypto_units" {
  type        = number
  description = "No of crypto units that has to be attached to the instance."
  default     = 2
}

variable "provision" {
  type        = bool
  description = "Flag indicating that hpcs instance should be provisioned. If 'false' then the instance is expected to already exist."
  default     = false
}

variable "name" {
  type        = string
  description = "The name that should be used for the service, particularly when connecting to an existing service. If not provided then the name will be defaulted to {name prefix}-{service}"
  default     = ""
}

variable "label" {
  type        = string
  description = "The label that will be used to generate the name from the name_prefix."
  default     = "hpcs"
}




