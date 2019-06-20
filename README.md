# SvelteWebpack

A really simple example of configuring Webpack to use the Svelte loader to help bundle up a bunch of Svelte components in order to have them render a application.

## Deploying the application to AWS

I have used Terraform to provision some simple infrastructure on which to deploy this app.

In order to properly configure your local environment prior to initialising and applying the Terraform scripts, it is recommended that you use `awsmfa` to go through the MFA process for an AWS profile of your choice. Once this is done, you can go ahead and run `terraform init` and `terraform apply` from the `terraform` directory in this project. 

Once the Terraform scripts have executed your AWS account will now have an Elastic Beanstalk environment in which the application can be deployed. The final step is to tell Elastic Beanstalk which version of the application to deploy onto your new Environment. This can be achieved on the CLI like so:

`aws --region $(terraform output region) elasticbeanstalk update-environment --environment-name $(terraform output environment_name) --version-label $(terraform output application_version)`

## Undeploying the application from AWS

If you provisioned the application using `terraform apply` then you can remove it using `terraform destroy`.
