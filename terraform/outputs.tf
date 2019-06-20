output "region" {
  value = "${var.region}"
}

output "environment_name" {
  value = "${aws_elastic_beanstalk_environment.svelte-app-development.name}"
}

output "application_version" {
  value = "${aws_elastic_beanstalk_application_version.svelte-app.name}"
}

