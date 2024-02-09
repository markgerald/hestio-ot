output "vpc_id" {
  value = aws_vpc.main_vpc.id
  description = "The ID of the VPC"
}

output "public_subnet_id" {
  value = aws_subnet.public.id
  description = "The ID of the public subnet"
}

output "private_subnet_id" {
  value = aws_subnet.private.id
  description = "The ID of the private subnet"
}
