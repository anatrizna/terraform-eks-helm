# VPC Resources
#  * VPC
#  * Two subnets
#  * Internet Gateway
#  * Route Table

resource "aws_vpc" "new" {
  cidr_block = "10.0.0.0/16"

  tags = map(
    "Name", "terraform-eks-node",
    "kubernetes.io/cluster/${var.cluster-name}", "shared",
  )
}

resource "aws_subnet" "new" {
  count = 2 

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.new.id

  tags = map(
    "Name", "terraform-eks-node",
    "kubernetes.io/cluster/${var.cluster-name}", "shared",
  )
}

resource "aws_internet_gateway" "new" {
  vpc_id = aws_vpc.new.id

  tags = {
    Name = "terraform-eks"
  }
}

resource "aws_route_table" "new" {
  vpc_id = aws_vpc.new.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.new.id
  }
}

resource "aws_route_table_association" "new" {
  count = 2

  subnet_id      = aws_subnet.new.*.id[count.index]
  route_table_id = aws_route_table.new.id
}
