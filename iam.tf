resource "aws_iam_role" "factorio_execution_role" {
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_role" "factorio_task_role" {
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF

  inline_policy {
    name   = "route53_access"
    policy = data.aws_iam_policy_document.access_route53.json
  }
}

resource "aws_iam_role_policy_attachment" "execution_role_policy_attachment" {
  role       = aws_iam_role.factorio_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

#$resource "aws_iam_role_policy_attachment"

data "aws_iam_policy_document" "access_route53" {
  statement {
    sid = "manage53"
    actions = [
      "route53:GetHostedZone",
      "route53:ChangeResourceRecordSets"
    ]

    resources = [
      data.aws_route53_zone.selected.arn
    ]
  }
}

#resource "aws_iam_role_policy" "ecs_firehose_delivery_role_policy" {
#  name = local.iam_policy_name
#  role = aws_iam_role.ecs_firehose_delivery_role.id
#
#  policy = <<EOF
#{
#    "Version": "2012-10-17",
#    "Statement": [
#        {
#            "Effect": "Allow",
#            "Action": [
#                "logs:CreateLogStream",
#                "logs:GetLogEvents",
#                "logs:PutLogEvents"
#            ],
#            "Resource": "*"
#        },
#        {
#            "Effect": "Allow",
#            "Action": [
#                "s3:put*",
#                "s3:get*",
#                "s3:list*"
#            ],
#            "Resource": "*"
#        },
#         {
#            "Effect": "Allow",
#            "Action": [
#                "kinesis:DescribeStream",
#                "kinesis:GetRecords"
#            ],
#            "Resource": [
#                "${aws_kinesis_stream.stepfunction_ecs_kinesis_stream.arn}"
#            ]
#        }
#    ]
#}
#EOF
#}
