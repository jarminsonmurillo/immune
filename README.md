# AWS Infrastructure Deployment with Terraform

This repository contains Terraform configurations to deploy a production-ready AWS infrastructure for a web application. The infrastructure is designed to be highly available, scalable, and secure.

## Features

### Networking
- **VPC**: A Virtual Private Cloud with CIDR `10.0.0.0/16`.
- **Subnets**: Public and private subnets distributed across multiple availability zones.
- **Internet Gateway**: Provides internet access to public subnets.
- **NAT Gateways**: Ensures private subnets can access the internet securely.

### Compute
- **Auto Scaling Groups**: Automatically scales EC2 instances for:
  - Web servers.
  - Application servers.
- **Elastic Load Balancers (ALB)**:
  - External ALB for public traffic.
  - Internal ALB for internal communication.

### Databases
- **RDS**: Managed relational database with a primary instance and a replica.
- **Elasticache**: Managed Redis cluster for caching.

### State Management
- **S3 Bucket**: Stores the Terraform state file securely with versioning enabled.

## File Structure
- `backend.tf`: Configures the Terraform backend to use S3 for state storage.
- `vpc.tf`: Defines the VPC, subnets, and networking resources.
- `nat_gateways.tf`: Configures NAT Gateways and Elastic IPs.
- `alb.tf`: Configures the Application Load Balancers.
- `asg.tf`: Defines Auto Scaling Groups for web and application servers.
- `databases.tf`: Configures RDS and Elasticache resources.

## Prerequisites
- Terraform installed on your local machine.
- AWS CLI configured with appropriate credentials.
- An AWS account with permissions to create the listed resources.

## Usage
1. Clone this repository:
   ```bash
   git clone <repository-url>
   ```
2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Plan the infrastructure:
   ```bash
   terraform plan
   ```
4. Apply the configuration:
   ```bash
   terraform apply
   ```

## Notes
- Ensure the AMI ID in the Auto Scaling Group configurations is updated to the latest Ubuntu 24.04 LTS AMI for your region.
- Default tags are applied to all resources using the `default_tags` block in the AWS provider.

## License
This project is licensed under the MIT License.