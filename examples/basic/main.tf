provider "aws" {
  region = "us-east-1" # IAM is global; any region works
}

module "praxis_role" {
  source      = "../.."
  external_id = "paste-the-external-id-from-your-praxis-connect-page"

  praxis_account_id = "123456789012" # from your praxis connect page
}

output "role_arn" {
  value = module.praxis_role.role_arn
}
