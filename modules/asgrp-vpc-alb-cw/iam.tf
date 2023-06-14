# IAM Role
resource "aws_iam_role" "ssm_mgmt" {
  name = "ssm-mgmt"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# Policy attachment to role
resource "aws_iam_role_policy_attachment" "ssm_mgmt_attachment" {
  role       = aws_iam_role.ssm_mgmt.id
  policy_arn = var.ssm_policy_arn
}

resource "aws_iam_role_policy_attachment" "cloudwatch_full_access_attachment" {
  role       = aws_iam_role.ssm_mgmt.id
  policy_arn = var.cloud_watch_policy_arn
}

# EC2 instance policy attachment
resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = "instance-profile"
  role = aws_iam_role.ssm_mgmt.name
   
    tags = {
    name = "instance-profile"
  }
}