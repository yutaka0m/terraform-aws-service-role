variable "description" {
  type        = string
  description = "The description of the role and the policy."
  default     = "Managed by Terraform"
}

##########################
# IAM Role
##########################
variable "iam_role_name" {
  description = "IAM role name"
  type        = string
}

variable "path" {
  description = "Path in which to create the role and the policy"
  type        = string
  default     = "/"
}

variable "max_session_duration" {
  description = "The maximum session duration (in seconds) that you want to set for the specified role."
  type        = "string"
  default     = "3600"
}

variable "force_detach_policies" {
  description = "Specifies to force detaching any policies the role has before destroying."
  type        = bool
  default     = false
}

variable "trusted_entity" {
  description = "The identity provider"
  type        = string
}

variable "tags" {
  description = "A map of tags to use on IAM Role"
  type        = map(string)
  default     = {}
}

##########################
# IAM Policy
##########################
variable "policies" {
  description = "name: Policy name / policy_json: IAM JSON Policy"
  type = list(object({
    name        = string
    json_policy = string
  }))
  default = []
}

variable "predefined_policy_arns" {
  description = "List of predefined policy ARN"
  type        = list(string)
  default     = []
}
