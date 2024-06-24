//@formatter:off
data "aws_region" "current" {}

data "aws_availability_zones" "available" {
    state = "available"
}
# Terraform Training VPC
resource "aws_vpc" "finlibro" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
}

resource "aws_internet_gateway" "finlibro-gw" {
    vpc_id = aws_vpc.finlibro.id
}

# Terraform Training Subnets
resource "aws_subnet" "finlibro-public-1" {
    vpc_id = aws_vpc.finlibro.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = data.aws_availability_zones.available.names[0]

}
resource "aws_subnet" "finlibro-public-2" {
    vpc_id = aws_vpc.finlibro.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = data.aws_availability_zones.available.names[1]
}
resource "aws_subnet" "finlibro-private-1" {
    vpc_id = aws_vpc.finlibro.id
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = data.aws_availability_zones.available.names[0]
}
resource "aws_subnet" "finlibro-private-2" {
    vpc_id = aws_vpc.finlibro.id
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = data.aws_availability_zones.available.names[1]
}

resource "aws_route_table" "finlibro-public" {
    vpc_id = aws_vpc.finlibro.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.finlibro-gw.id
    }
}

# Terraform Training RTA
resource "aws_route_table_association" "finlibro-public-1-a" {
    subnet_id = aws_subnet.finlibro-public-1.id
    route_table_id = aws_route_table.finlibro-public.id
}

resource "aws_route_table_association" "finlibro-public-2-a" {
    subnet_id = aws_subnet.finlibro-public-2.id
    route_table_id = aws_route_table.finlibro-public.id
}
//@formatter:on
