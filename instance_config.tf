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
    Name = "mongo-${count.index}"
    Owner ="Slavko"
    Terraform = "true"
    Environment = "dev"
  }
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 1024
    volume_type = "standard"
  }

  user_data {
    #!/bin/bash
    # This file prepares the system to run Docker containers
    hostname = "mongo-${count.index}"
    fqdn = "mongo-${count.index}.${var.DnsZoneName}"
    # Run a yum update
    sudo yum -y update

    # Install Docker
    yum install -y yum-utils device-mapper-persistent-data lvm2
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    yum install docker-ce
    systemctl start docker

    #Map Log volume to /logs
    mkfs -t ext4 /dev/xvdf
    mkdir /mongologs
    mount /dev/xvdf /mongodata
    echo /dev/xvdf  /mongodata ext4 defaults 0 0 >> /etc/fstab
    mkdir -p /dockerlocalstorage/data/mongodb
    mkdir -p /dockerlocalstorage/logs/mongodb
    mkdir -p /dockerlocalstorage/backup/mongodb
    # Deploy MongoDB container
    # The following code is a quick way to get mongo up and running,
    # but will not create a Mongo cluster
    # docker run -d -p 27017:27017 -p 28017:28017 -e MONGODB_USER="user" -e MONGODB_DATABASE="mydatabase" -e MONGODB_PASS="mypass" --name mongo-3.4 dubc/mongodb --logpath /mongodata/logs/mongod.log

    docker pull mongo
    docker network create mongo-cluster
    docker run \
    -p 27017:27017 \
    --name mongo-${count.index}.${var.DnsZoneName} \
    --net mongo-cluster \
    mongo mongod --replSet my-mongo-set
  }
}

/* Route53 Record Creation */

resource "aws_route53_zone" "main" {
  name = "test.com"
}

resource "aws_route53_record" "host" {

  count = "${var.num_instances}"
  zone_id = "mongo-${count.index}.${var.DnsZoneName}"
  name = "${count.index}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.host.*.private_ip, count.index)}"]
}