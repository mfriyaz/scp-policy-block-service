terraform {
  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_organizations_organization" "org" {}

resource "aws_organizations_policy" "deny_ec2_without_tags" {
  name        = "Deny-EC2-Without-Tags"
  description = "Deny EC2 creation without Environment and Owner tags"
  type        = "SERVICE_CONTROL_POLICY"

  content = file("${path.module}/policies/deny-ec2-without-tags.json")
}

resource "aws_organizations_policy_attachment" "attach_scp_root" {
  policy_id = aws_organizations_policy.deny_ec2_without_tags.id
  target_id = data.aws_organizations_organization.org.roots[0].id
}
