data "archive_file" "svelte-app" {
  type        = "zip"
  source_dir  = "../public"
  output_path = "../dist/svelte-app-${var.application_version}.zip"
}

resource "aws_s3_bucket" "default" {
  bucket = "svelte.application.${var.application_version}"
}

resource "aws_s3_bucket_object" "default" {
  bucket = "${aws_s3_bucket.default.id}"
  key    = "svelte-app-${var.application_version}.zip"
  source = "../dist/svelte-app-${var.application_version}.zip"
}

resource "aws_iam_role" "svelte-elasticbeanstalk-ec2-role" {
  name = "svelte-elasticbeanstalk-ec2-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "svelte-elasticbeanstalk-web-tier-attachment" {
  role          = "${aws_iam_role.svelte-elasticbeanstalk-ec2-role.name}"
  policy_arn    = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_role_policy_attachment" "svelte-elasticbeanstalk-multicontainer-docker-attachment" {
  role          = "${aws_iam_role.svelte-elasticbeanstalk-ec2-role.name}"
  policy_arn    = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}

resource "aws_iam_role_policy_attachment" "svelte-elasticbeanstalk-worker-tier-attachment" {
  role          = "${aws_iam_role.svelte-elasticbeanstalk-ec2-role.name}"
  policy_arn    = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
}

resource "aws_elastic_beanstalk_application" "svelte-app" {
  name        = "svelte-app"
  description = "An example Svelte application"
}

resource "aws_elastic_beanstalk_application_version" "svelte-app" {
  name        = "svelte-app-${var.application_version}-${var.environment}"
  application = "${aws_elastic_beanstalk_application.svelte-app.name}"
  description = "An example Svelte application"
  bucket      = "${aws_s3_bucket.default.id}"
  key         = "${aws_s3_bucket_object.default.id}"
}

resource "aws_iam_instance_profile" "svelte-elasticbeanstalk-ec2-role" {
  name = "svelte-elasticbeanstalk-ec2-role"
  role = "${aws_iam_role.svelte-elasticbeanstalk-ec2-role.name}"
}

resource "aws_elastic_beanstalk_environment" "svelte-app-development" {
  name                = "svelte-app-development"
  application         = "${aws_elastic_beanstalk_application.svelte-app.name}"
  solution_stack_name = "64bit Amazon Linux 2018.03 v4.9.2 running Node.js"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "IamInstanceProfile"
    value = "${aws_iam_instance_profile.svelte-elasticbeanstalk-ec2-role.name}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "InstanceType"
    value = "t2.micro"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name = "MinSize"
    value = "1"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name = "MaxSize"
    value = "2"
  }
}
