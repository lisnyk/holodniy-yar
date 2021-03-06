## Deployment of a MongoDB Cluster into an AWS Environment

### Summary
This document is intended for system engineers responsible for environment deployments. It is intended for deploying a 3 node MongoDB cluster into an AWS EC2 instances using Docker.

### Requirements
It is assumed that a valid VPC is already in place. Personal executing this deployment must have sufficient privileges in that VPC and have either a bastion, or VPN access established in order to be able to test this system. Tools such as Terraform and Ansible, must be already installed on your system.

### Obtaining the code
All code for this project is available on GitHub at https://github.com/lisnyk/holodniy-yar
Clone this repository to your workstation and become familiar with contents. All values in variables.tf, key files and host Ips in inventory/hosts contain sample data which may be different from what is available in your environment.

### Filling out the blanks
Please pay attention to variables.tf file, as it contains all of the customizable elements about your environment. Please enter your AWS Access Kye and AWS Secret Key so that you are able to access AWS account and perform the deployment. Please check each parameter and ensure that values are relevant and change them as appropriate.

### Performing deployments
1. The deployment and configuration of EC2 instances, associated DNS entries and relevant subnets will be performed by Terraform. The deployment of actual MongoDB containers will be handled by Ansible.
2. Open a terminal shell on your system and navigate to the folder that contains files that you downloaded and reviewed in previous steps. Execute the following commands:
	$ terraform init
	$ terraform apply
3. Once all items are created, there will be output on your screen displaying three IP addresses.These are the IP addresses of each EC2 instance
