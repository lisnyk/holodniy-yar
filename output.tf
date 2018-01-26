output "master_public_ip" {
    value = ["${aws_instance.MongoHost.*.private_ip}"]
}