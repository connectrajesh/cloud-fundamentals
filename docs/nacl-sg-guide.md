# AWS Network Security Configuration with Terraform

This Terraform code provides an example of how to configure network security in AWS using Network ACLs (NACLs) and Security Groups (SGs). The code is intended to be used as a reference and starting point for your own AWS security configurations.

## Prerequisites

Before running this Terraform code, you must have:

- An AWS account
- Terraform installed on your local machine
- AWS CLI installed on your local machine
- AWS credentials configured on your local machine

## Usage

1. Clone the repository to your local machine:

git clone https://github.com/connectrajesh/cloud-fundamentals.git

2. Navigate to the repository directory:

cd cloud-fundamentals


3. Modify the code in the `nacl-sg-example.tf` file to match your own network configuration, replacing the example VPC, subnets, and security group rules with your own.

4. Initialize the Terraform configuration:

terraform init


5. Preview the changes that Terraform will make to your AWS infrastructure:

terraform plan


6. Apply the changes to your AWS infrastructure:

terraform apply


## Resources

- [AWS VPC Network ACLs](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html)
- [AWS VPC Security Groups](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)
- [Terraform Documentation](https://www.terraform.io/docs/index.html)
