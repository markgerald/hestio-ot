variable "vpc_id" {
  description = "The VPC ID"
  type = string
}
variable "public_subnet_id" {
    description = "The public subnet ID"
    type = string
}
variable "private_subnet_id" {
    description = "The private subnet ID"
    type = string
}
variable "instance_type" {
    description = "The instance type"
    type = string
}
