output "scp_policy_id" {
  value = aws_organizations_policy.deny_ec2_without_tags.id
}

output "applied_to_root" {
  value = data.aws_organizations_organization.org.roots[0].id
}
