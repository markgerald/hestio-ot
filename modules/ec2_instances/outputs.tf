output "public_instance_id" {
  value = aws_instance.public_instance.id
  description = "The ID of the public instance"
}

output "private_instance_id" {
  value = aws_instance.private_instance.id
  description = "The ID of the private instance"
}

output "public_instance_ip" {
  value = aws_instance.public_instance.public_ip
  description = "The public IP of the public instance"
}
