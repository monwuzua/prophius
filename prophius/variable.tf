variable "aws_access_key" {
  description = "AWS access key used for authentication."
  default     = "whwbfjenddndjdnmdkjdmdkjdnd"
}

variable "aws_secret_key" {
  description = "AWS secret key used for authentication."
  default     = "ajsjdnxjdmdjdndkdidmdididmdj"
}

variable "region" {
  description = "The AWS region where resources will be created."
  default     = "us-east-1"
}

variable "docker_registry_username" {
  description = "Username for accessing the Docker registry."
  default     = "admin2"
}

variable "docker_registry_password" {
  description = "Password for accessing the Docker registry."
  default     = "prophius@102"
}

variable "mysql_username" {
  description = "Username for MySQL database."
  default     = "admin"
}

variable "mysql_password" {
  description = "Password for MySQL database."
  default     = "prophius@101"
}


variable "subnet_cidr_block" {
  description = "CIDR block for the subnet."
  default = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability zone for the subnet."
  default = "us-west-2a"
}

variable "db_allocated_storage" {
  description = "Allocated storage for the MySQL database."
  default = 20
}

variable "db_storage_type" {
  description = "Storage type for the MySQL database."
  default = "gp2"
}

variable "db_engine" {
  description = "Database engine for the MySQL database."
  default = "mysql"
}

variable "db_engine_version" {
  description = "Database engine version for the MySQL database."
  default = "5.7"
}

variable "db_instance_class" {
  description = "Instance class for the MySQL database."
  default = "db.t2.micro"
}

variable "db_name" {
  description = "Name of the MySQL database."
  default = "mydb"
}
