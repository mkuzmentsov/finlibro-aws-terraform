//@formatter:off
//# Terraform Training RT
resource "aws_nat_gateway" "finlibro-nat-gw" {
    allocation_id = var.finlibro-nat-eip-allocation-id
    subnet_id = var.finlibro-network-finlibro-public-1-id
}

resource "aws_route_table" "finlibro-private" {
    vpc_id = var.finlibro-vpc-id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.finlibro-nat-gw.id
    }
    depends_on = [
        aws_nat_gateway.finlibro-nat-gw
    ]
}

resource "aws_route_table_association" "finlibro-private-1-a" {
    subnet_id = var.finlibro-network-finlibro-private-1-id
    route_table_id = aws_route_table.finlibro-private.id
    depends_on = [
        aws_route_table.finlibro-private
    ]
}
resource "aws_route_table_association" "finlibro-private-2-a" {
    subnet_id = var.finlibro-network-finlibro-private-2-id
    route_table_id = aws_route_table.finlibro-private.id
    depends_on = [
        aws_route_table.finlibro-private
    ]
}
//@formatter:on
