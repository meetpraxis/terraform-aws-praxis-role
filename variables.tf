variable "external_id" {
  description = "The external ID shown on your praxis connect page. praxis assumes the role only with this value."
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z0-9_+=,.@:/-]{32,64}$", var.external_id))
    error_message = "external_id must be 32 to 64 characters from A-Z a-z 0-9 _ + = , . @ : / -"
  }
}

