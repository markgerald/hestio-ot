output "public_instance_ip" {
  value = module.ec2_instances.public_instance_ip
  description = "The public IP address of the main instance"
}