provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.availability_zone
}

resource "docker_registry_image" "private_registry" {
  name       = "prophius_acr"
  repository = "prophius"
  username   = var.docker_registry_username
  password   = var.docker_registry_password
}

resource "aws_db_instance" "mysql" {
  allocated_storage    = var.db_allocated_storage
  storage_type         = var.db_storage_type
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  name                 = var.db_name
  username             = var.mysql_username
  password             = var.mysql_password
}

resource "aws_security_group" "eks_cluster_sg" {
  name        = "eks-cluster-sg"
  description = "Security group for the EKS cluster"
  vpc_id      = aws_vpc.my_vpc.id

  // Define your ingress and egress rules here
  // Example:
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Add more rules as needed
}

resource "aws_eks_cluster" "my_cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = [aws_subnet.subnet_1.id]  # Add more subnet IDs if needed
    security_group_ids = [aws_security_group.eks_cluster_sg.id]
  }
}

resource "aws_iam_role" "eks_cluster" {
  name = "eks-cluster-role"

  // Attach necessary policies to the role
  // Example:
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}

resource "aws_resourcegroups_group" "my_resource_group" {
  name = "my-resource-group"
  // Add tags or other configurations as needed
}

// Add resources to the resource group
resource "aws_resourcegroups_group_membership" "vpc_membership" {
  resource_group_name = aws_resourcegroups_group.my_resource_group.name
  resource_arn        = aws_vpc.my_vpc.arn
}

resource "aws_resourcegroups_group_membership" "subnet_membership" {
  resource_group_name = aws_resourcegroups_group.my_resource_group.name
  resource_arn        = aws_subnet.subnet_1.arn
}

resource "aws_resourcegroups_group_membership" "registry_membership" {
  resource_group_name = aws_resourcegroups_group.my_resource_group.name
  resource_arn        = docker_registry_image.private_registry.arn
}

resource "aws_resourcegroups_group_membership" "db_membership" {
  resource_group_name = aws_resourcegroups_group.my_resource_group.name
  resource_arn        = aws_db_instance.mysql.arn
}

resource "aws_resourcegroups_group_membership" "sg_membership" {
  resource_group_name = aws_resourcegroups_group.my_resource_group.name
  resource_arn        = aws_security_group.eks_cluster_sg.arn
}

resource "aws_resourcegroups_group_membership" "eks_membership" {
  resource_group_name = aws_resourcegroups_group.my_resource_group.name
  resource_arn        = aws_eks_cluster.my_cluster.arn
}

resource "aws_resourcegroups_group_membership" "role_membership" {
  resource_group_name = aws_resourcegroups_group.my_resource_group.name
  resource_arn        = aws_iam_role.eks_cluster.arn
}
