output "finlibro-vpc-id" {

  value = aws_vpc.finlibro.id
}

output "finlibro-public-1-network-id" {

  value = aws_subnet.finlibro-public-1.id
}

output "finlibro-public-2-network-id" {

  value = aws_subnet.finlibro-public-2.id
}

output "finlibro-private-1-network-id" {

  value = aws_subnet.finlibro-private-1.id
}

output "finlibro-private-2-network-id" {

  value = aws_subnet.finlibro-private-2.id
}

output "finlibro-internet-gateway-id" {

  value = aws_internet_gateway.finlibro-gw.id
}

//output "finlibro-private-1-network-id" {
//
//  value = aws_subnet.finlibro-public-1.id
//}
//
//output "finlibro-private-2-network-id" {
//
//  value = aws_subnet.finlibro-public-2.id
//}