resource "aws_iam_role" "role" {
  count = length(var.policy_list) > 0 ? 1 : 0
  name = "${var.tool_name}-role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF

  inline_policy {
    name = "${var.tool_name}-inline-role"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = var.policy_list
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }

  tags = {
    Name = "${var.tool_name}-role"
  }
}

resource "aws_iam_instance_profile" "instance_profile" {
  count = length(var.policy_list) > 0 ? 1 : 0
  name = "${var.tool_name}-role"
  role = aws_iam_role.role[0].name
}

# Already we created a iam role called workstation-role, go to that and get the 'Trust relationships' info into here , see above for same code used
# "Version": "2012-10-17",
# "Statement": [
# {
# "Effect": "Allow",
# "Principal": {
# "Service": "ec2.amazonaws.com"
# },
# "Action": "sts:AssumeRole"
# }
# ]

# aws_iam_instance_profile: if u want to attach a role to instance, we need this part