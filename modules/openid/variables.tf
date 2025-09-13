variable "thumbprint_list" {
  description = "List of thumbprints for OIDC provider"
  type        = list(string)
}

variable "url" {
  description = "OIDC provider URL"
  type        = string
  default     = "https://token.actions.githubusercontent.com"
}

variable "role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "role_path" {
  description = "Path for the IAM role"
  type        = string
  default     = "/"
}

variable "policy_name" {
  description = "Name of the IAM policy"
  type        = string
}

variable "policy_path" {
  description = "Path for the IAM policy"
  type        = string
  default     = "/"
}

variable "description" {
  description = "Description of the IAM role"
  type        = string
}

variable "max_session_duration" {
  description = "Maximum session duration for the role in seconds"
  type        = number
  default     = 3600
}

variable "sub_conditions" {
  description = "List of sub conditions for OIDC"
  type        = list(string)
}

variable "policy_actions" {
  description = "List of allowed actions in the policy"
  type        = list(string)
}

variable "policy_resources" {
  description = "List of resources for the policy"
  type        = list(string)
}