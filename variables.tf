variable "aws_region" {
  description = "AWS region for the provider"
  type        = string
  default     = "ap-south-1"
}

variable "user_names" {
  description = "IAM users to create"
  type        = set(string)
  default     = ["s3-reader-1", "s3-reader-2"]
}

variable "group_name" {
  description = "IAM group that carries the S3 read policy"
  type        = string
  default     = "s3-readers"
}

variable "policy_name" {
  description = "Name of the managed IAM policy"
  type        = string
  default     = "s3-read-only-policy"
}

# The policy lives in a variable, so you can change permissions without touching main.tf
variable "s3_read_policy" {
  description = "Allowed actions and resources for the S3 read policy"
  type = object({
    actions   = list(string)
    resources = list(string)
  })
  default = {
    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
      "s3:ListBucket",
      "s3:GetObject",
    ]
    resources = ["*"]
  }
}

variable "create_access_keys" {
  description = "Create access keys for testing (secrets end up in Terraform state - lab use only)"
  type        = bool
  default     = true
}

variable "tags" {
  type = map(string)
  default = {
    Project   = "capstone-project-4"
    ManagedBy = "terraform"
  }
}
