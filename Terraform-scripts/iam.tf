data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}
//resource "aws_iam_instance_profile" "Production" {
 // name = "production-instance-profile"
  //role = "production-role"
//}

resource "aws_iam_role" "vprofile-app-role1" {
  name = "vprofile-app-role1"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "vprofile_full_admin_attachment" {
  role       = aws_iam_role.vprofile-app-role1.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "vprofile_s3_attachment" {
  role       = aws_iam_role.vprofile-app-role1.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  role       = aws_iam_role.vprofile-app-role1.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

