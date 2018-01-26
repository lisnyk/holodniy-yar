variable "region" {
  default = "us-east-1"
}
variable "aws_access_key" {
  default = "XXXYYYXXXYYY"
  description = "the user aws access key"
}
variable "num_instances" {
  default = 3
 }
variable "aws_secret_key" {
  default = "zxsadgsgsvxzzcvsvgs"
  description = "the user aws secret key"
}
variable "ami_name" {
	description = "AMI to use for deployments"
	default = "ami-0987654"
}
variable "vpc_id" {
	description = "VPC to target for deployments"
	default = "vpc-123456789"
}
variable "azs" {
  description = "Run the EC2 Instances in these Availability Zones"
  type = "list"
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
variable "vpc-fullcidr" {
    default = "172.28.0.0/16"
  description = "the vpc cidr"
}
variable "Subnet-Private-AzA-CIDR" {
  default = ["172.28.1.0/24", "172.28.2.0/24", "172.28.3.0/24"]
  description = "the cidr of the subnet"
}
variable "sub-ids" {
  description = "Cheat for existing Subnet IDs until we find a better way"
  type = "list"
  default = ["subnet-123", "subnet-456", "subnet-789"]
}
variable "DnsZoneName" {
  default = "test.com"
  description = "the internal dns name"
}
variable "key_path" {
  description = "SSH Public Key path"
  default = "keys/mongohost.pem"
}
variable "key_name" {
  description = "Desired name of Keypair..."
  default = "mongohost-key"
}