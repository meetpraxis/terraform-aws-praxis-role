# terraform-aws-praxis-role

Creates the read-only `PraxisAuditRole` that lets [praxis](https://meetpraxis.io) check the configuration of every account in your AWS Organization. Deploy it once in the management account: it creates the role there and, through a service-managed CloudFormation StackSet, in every member account, including accounts added later. The role carries the AWS managed `SecurityAudit` policy plus `organizations:ListAccounts`, `organizations:DescribeOrganization` and `account:ListRegions`, and trusts praxis only with the external ID shown on your praxis connect page. It grants no write access and creates no access keys.

Status: not released yet. Usage, inputs and outputs arrive with version `1.0.0`.

Licensed under the Apache License 2.0.
