resource "aws_iam_role_policy" "ssm_policy" {
  name = "${var.name}-${terraform.workspace}-ssm-policy"
  role = aws_iam_role.ssm_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ssm:DescribeAssociation",
          "ssm:GetParameter",
          "ssm:GetParameters"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "ssm_role" {
  name = "${var.name}-${terraform.workspace}-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "${var.name}-${terraform.workspace}-ssm-profile"
  role = aws_iam_role.ssm_role.name
}
