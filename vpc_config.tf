provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}

/* VPC Creation block commented out, as we assume that VPc already exists

resource "aws_vpc" "terraformmain" {
    cidr_block = "${var.vpc-fullcidr}"
   #### this 2 true values are for use the internal vpc dns resolution
    enable_dns_support = true
    enable_dns_hostnames = true
    tags {
      Name = "DataRobotTest"
      Owner ="Slavko"
      Terraform = "true"
      Environment = "dev"
    }
}
Commented out */

/* EXTERNAL NETWORKING, IG, ROUTE TABLE */
resource "aws_internet_gateway" "gw" {
   vpc_id = "${var.vpc_id}"
    tags {
        Name = "internet gw terraform generated"
    }
}
resource "aws_network_acl" "all" {
   vpc_id = "${var.vpc_id}"
    egress {
        protocol = "-1"
        rule_no = 2
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }
    ingress {
        protocol = "-1"
        rule_no = 1
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }
    tags {
        Name = "open acl"
    }
}