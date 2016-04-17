# Environment
#
# Set the following as environment variable.
# For example: TF_VAR_aws_ssh_key_name

variable "aws_access_key_id" {
}

variable "aws_access_key_secret" {
}

variable "aws_ssh_key_name" {
}

variable "aws_ssh_private_key_file" {
}

variable "safe_ssh_ip" {
}

variable "aws_ssh_user" {
	default = "ubuntu" # defined by aws_worker_ami
}

# AWS

variable "aws_region" {
	default = "eu-west-1"
}

variable "aws_worker_ami" {
	default = "ami-f95ef58a"
}

variable "aws_worker_instance_type" {
	default = "t2.micro"
}

# Workers

variable "worker_count" {
    default = 2
}