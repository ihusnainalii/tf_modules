############ OutPuts ###########
output "List_of_AZs" {
  value = data.aws_availability_zones.available
}
output "private_subnets_id" {
  value = aws_subnet.private_sb.id
}
output "public_subnets_id" {
  value = aws_subnet.public_sb.id
}
