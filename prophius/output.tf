output "eks_cluster_name" {
  value = aws_eks_cluster.my_cluster.name
}

output "eks_cluster_arn" {
  value = aws_eks_cluster.my_cluster.arn
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "subnet_id" {
  value = aws_subnet.subnet_1.id
}

output "security_group_id" {
  value = aws_security_group.eks_cluster_sg.id
}

output "database_endpoint" {
  value = aws_db_instance.mysql.endpoint
}
