# Running the Terraform Project with OpenTofu


This guide provides step-by-step instructions on how to run this Terraform project using OpenTofu. The project sets up cloud infrastructure on AWS, including VPCs, subnets, and EC2 instances. Follow these steps to initialize, plan, and apply your Terraform configurations.

## Prerequisites

Before you begin, ensure you have the following installed:

-   Terraform
-   AWS CLI, configured with appropriate credentials
-   OpenTofu CLI (`tofu`)

## Step 0: Create a Bucket on console or Cli

Create a bucket in the us-east-1 region, with any name such as "our-backend-state-bucket" for use in the configuration of remote backend.

## Step 1: Generate an SSH Key

First, you need to generate an SSH key that will be used by the EC2 instances for secure SSH access. Run the following command:

```bash 
ssh-keygen -t rsa -b 2048 -f modules/ec2_instances/terraform-ec2-key
```

This command generates a new SSH key pair in the `modules/ec2_instances/` directory. Keep the private key safe and secure.

## Step 2: Initialize the Project with OpenTofu

Initialize your Terraform project with OpenTofu. This step prepares your project for deployment by setting up the remote backend for state management and installing necessary plugins.

Run the following command:

```bash 
tofu init -backend-config="bucket=our-backend-state-bucket" -backend-config="key=dev/tofu.tfstate" -backend-config="region=us-east-1"
``` 

This initializes the Terraform backend to store the state file in an S3 bucket named `terraform-state-hestion` in the `us-east-1` region.

## Step 3: Create a Workspace

Create a new workspace for your development environment. Workspaces allow you to manage different states for different environments (e.g., development, staging, production).

```bash 
tofu workspace new dev
``` 

## Step 4: Plan Your Infrastructure

Generate an execution plan for Terraform. This step allows you to review the changes that will be made to your infrastructure before applying them.

```bash 
tofu plan -out "plan.out"
```

This command saves the plan to a file named `plan.out`. Review this plan to ensure it matches your expected infrastructure changes.

## Step 5: Apply the Configuration

Apply the Terraform configuration to provision your AWS infrastructure.

```bash 
tofu apply plan.out
``` 

This command applies the plan saved in `plan.out`. Confirm the action when prompted to proceed with the infrastructure creation.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2_instances"></a> [ec2\_instances](#module\_ec2\_instances) | ./modules/ec2_instances | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_instance_ip"></a> [public\_instance\_ip](#output\_public\_instance\_ip) | The public IP address of the main instance |
<!-- END_TF_DOCS -->