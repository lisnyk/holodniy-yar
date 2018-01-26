/* Creating Instances and loading Docker containers */
resource "aws_instance" "MongoHost" {
  count = "${var.num_instances}"
  ami = "${var.ami_name}"
  instance_type = "t2.micro"
  availability_zone = "${element(var.azs, count.index)}"
  associate_public_ip_address = "true"
  subnet_id = "${element(var.sub-ids, count.index)}"
  vpc_security_group_ids = ["${aws_security_group.MongoDB.id}"]
  key_name = "${var.key_name}"
    tags {
    Name = "mongo-${count.index}.${var.DnsZoneName}"
    Owner ="Slavko"
    Terraform = "true"
    Environment = "dev"
  }
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 1024
    volume_type = "standard"
  }

  user_data = ${file("sysprep.sh")}
}

/* Route53 Record Creation */

resource "aws_route53_zone" "main" {
  name = "test.com"
}

resource "aws_route53_record" "host" {

  count = "${var.num_instances}"
  zone_id = ""mongo-${count.index}.${var.DnsZoneName}"
  name = "${count.index}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.host.*.private_ip, count.index)}"]
}