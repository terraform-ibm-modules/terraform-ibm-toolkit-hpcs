
# COS Credentials
variable "api_key" {
  type        = string
  description = "api key of the COS bucket"
}
variable "cos_crn" {
  type        = string
  description = "COS instance CRN"
}
variable "endpoint" {
  type        = string
  description = "COS endpoint"
}
variable "bucket_name" {
  type        = string
  description = "COS bucket name"
}
# Input Json file
variable "input_file_name" {
  type        = string
  description = "Input json file name that is present in the cos-bucket or in the local"
}
variable "initialize" {
  type        = bool
  description = "Flag indicating that if user want to initialize the hpcs instance. If 'true' then the instance is expected to initialize."
  default     = false
}
# Input Json file
variable "hpcs_instance_guid" {
  type        = string
  description = "HPCS Instance GUID"
}
variable "region" {
  default     = "us-south"
  type        = string
  description = "Location of HPCS Instance"
}

variable "service_name" {
  type        = string
  description = "Name of HPCS Instance"
  default     = "hs-crypto"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
  default     = "slz-rg"
}

variable "allowed_network_type" {
  description = "The network access policy to apply to your Hyper Protect Crypto Services instance. Acceptable values are public-and-private or private-only.After the network access policy is set to private-only, you cannot access your instance from the public network and cannot view or manage keys through the UI. However, you can still adjust the network setting later using the API or CLI"
  default     = "public-and-private"
  type        = string
}

variable "hpcs_port" {
  description = "HPCS service port"
  type        = number
}

variable "dual_auth_delete" {
  description = "Dual auth deletion policy enabled or not"
  default     = true
  type        = bool
}
variable "tke_files_path" {
  type        = string
  description = "Path to which tke files has to be exported"
}

