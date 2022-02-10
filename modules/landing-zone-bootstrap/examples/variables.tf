/**
 * Copyright 2019 Google LLC
 *
 * Copyright 2021 Google LLC. This software is provided as is, without
 * warranty or representation for any use or purpose. Your use of it is
 * subject to your agreement with Google.
*/

variable "parent" {
  type = string
}

variable "billing_account" {
  type = string
}

variable "org_id" {
  type = string
}

variable "bootstrap_email" {
  type = string
}


# naming
variable "department_code" {
  type        = string
  description = "Code for department, part of naming module"
  default     = "Ut"
}

variable "environment" {
  type        = string
  description = "S-Sandbox P-Production Q-Quality D-development"
  default     = "D"
}

variable "location" {
  type        = string
  description = "location for naming and resource placement"
  default     = "northamerica-northeast1"
}

variable "owner" {
  type        = string
  description = "Division or group responsible for security and financial commitment."
  default     = "unittest"
}

variable "user_defined_string" {
  type        = string
  description = "User defined string."
  default     = ""
}

variable "additional_user_defined_string" {
  type        = string
  description = "Additional user defined string."
  default     = ""
}