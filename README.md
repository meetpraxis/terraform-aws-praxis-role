# terraform-aws-praxis-role

Creates the read-only `PraxisAuditRole` that lets [praxis](https://meetpraxis.io) check the configuration of one AWS account. The role carries the AWS managed `SecurityAudit` policy and nothing else, and trusts praxis only with the external ID shown on your praxis connect page. It grants no write access, creates no access keys and calls no praxis endpoint. The module contains one role, its trust policy and one policy attachment.

## Usage

From the Terraform Registry:

```hcl
module "praxis_role" {
  source      = "meetpraxis/praxis-role/aws"
  version     = "1.0.0"
  external_id = "<the external ID from your praxis connect page>"
}

output "role_arn" {
  value = module.praxis_role.role_arn
}
```

From git:

```hcl
module "praxis_role" {
  source      = "git::https://github.com/meetpraxis/terraform-aws-praxis-role.git?ref=1.0.0"
  external_id = "<the external ID from your praxis connect page>"
}
```

Configure the `aws` provider for the account to be checked, with permission to create an IAM role. Apply, then paste the `role_arn` output on the praxis connect page and pick the regions to check.

## Inputs

| Name | Type | Default | Description |
|---|---|---|---|
| `external_id` | string | none, required | The external ID from your connect page. 32 to 64 characters. |

## Outputs

| Name | Description |
|---|---|
| `role_arn` | ARN of `PraxisAuditRole`. |

## Rollback

`terraform destroy` removes the role. praxis then marks the connection failed, keeps the last findings visible as stale, and deletes nothing.

Licensed under the Apache License 2.0.
