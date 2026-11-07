#!/usr/bin/env bash
# Fails if the role grants anything beyond the AWS managed SecurityAudit policy (Constitution I,
# contracts/onboarding.md). Scans *.tf, *.yaml and *.yml outside .github/ and examples/.
# Allowed: managed policy SecurityAudit, the trust action sts:AssumeRole, the condition key sts:ExternalId.
set -euo pipefail
cd "$(dirname "$0")/.."
files=$(find . \( -name '*.tf' -o -name '*.yaml' -o -name '*.yml' \) -not -path './.github/*' -not -path './examples/*' -not -path './.terraform/*')
[ -z "$files" ] && { echo "policy-diff: no files to scan"; exit 0; }
fail=0
# 1. Any managed policy other than SecurityAudit.
while IFS= read -r hit; do
  echo "policy-diff: forbidden managed policy: $hit"; fail=1
done < <(grep -nE 'arn:aws[a-z-]*:iam::aws:policy/' $files | grep -vE 'policy/SecurityAudit([^A-Za-z0-9]|$)' || true)
# 2. Any IAM action string (service:Action or service:*) other than the two allowed.
while IFS= read -r hit; do
  echo "policy-diff: forbidden action: $hit"; fail=1
done < <(grep -nE '["'"'"' ,\[-]([a-z0-9-]+):([A-Z][A-Za-z0-9]*|\*)["'"'"' ,\]]?' $files \
  | grep -vE 'sts:AssumeRole|sts:ExternalId|arn:aws|AWS::|::' || true)
# 3. A bare wildcard action or resource grant.
while IFS= read -r hit; do
  echo "policy-diff: wildcard grant: $hit"; fail=1
done < <(grep -nEi '(action|actions|resource|resources)"?[:=]? *\[?"\*"' $files || true)
[ "$fail" -eq 0 ] && echo "policy-diff: ok (SecurityAudit only)"
exit "$fail"
