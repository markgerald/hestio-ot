# Running the Terraform Project with OpenTofu


This guide provides step-by-step instructions on how to run this Terraform project using OpenTofu. The project sets up cloud infrastructure on AWS, including VPCs, subnets, and EC2 instances. Follow these steps to initialize, plan, and apply your Terraform configurations.

## Prerequisites

Before you begin, ensure you have the following installed:

-   Terraform
-   AWS CLI, configured with appropriate credentials
-   OpenTofu CLI (`tofu`)

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
tofu init -backend-config="bucket=terraform-state-hestion" -backend-config="key=dev/tofu.tfstate" -backend-config="region=us-east-1"
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