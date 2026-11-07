variable "external_id" {
  description = "The external ID shown on your praxis connect page. praxis assumes the role only with this value."
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z0-9_+=,.@:/-]{32,64}$", var.external_id))
    error_message = "external_id must be 32 to 64 characters from A-Z a-z 0-9 _ + = , . @ : / -"
  }
}

variable "praxis_account_id" {
  description = "praxis's AWS account ID, shown prefilled on the praxis connect page (public; it appears in every trust policy)."
  type        = string
  # TODO(founder, T049): set `default` to praxis's public AWS account ID before tagging 1.0.0 (contracts/onboarding.md).

  validation {
    condition     = can(regex("^[0-9]{12}$", var.praxis_account_id))
    error_message = "praxis_account_id must be a 12-digit AWS account ID."
  }
}
