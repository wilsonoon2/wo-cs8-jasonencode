# Wilson OON CS-8 14th March 2026


locals {
 name_prefix = "woj"
}

resource "aws_iam_role" "role_example" {
 name = "${local.name_prefix}-role-example"

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

resource "aws_iam_policy" "policy_example" {
 name = "${local.name_prefix}-policy-example"

 ## Option 2: Inline using jsonencode
 policy = jsonencode({
   Version = "2012-10-17"
   Statement = [
     {
       Action   = ["ec2:Describe*"]
       Effect   = "Allow"
       Resource = "*"
     },
     {
       Action   = ["s3:ListBucket"]
       Effect   = "Allow"
       Resource = "*"
     },
   ]
 })
}


resource "aws_iam_role_policy_attachment" "attach_example" {
 role       = aws_iam_role.role_example.name
 policy_arn = aws_iam_policy.policy_example.arn
}

resource "aws_iam_instance_profile" "profile_example" {
 name = "${local.name_prefix}-profile-example"
 role = aws_iam_role.role_example.name
}

