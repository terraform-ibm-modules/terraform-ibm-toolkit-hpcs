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
