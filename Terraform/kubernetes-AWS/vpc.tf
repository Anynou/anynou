resource "aws_vpc" "kubernetes" {

	cidr_block = "10.0.0.0/16"
	enable_dns_support   = true
  	enable_dns_hostnames = true
	
	tags = {
		Name = "kubernetes"
	}
}

resource "aws_subnet" "redA" {
	vpc_id = "${aws_vpc.kubernetes.id}"
	cidr_block = "10.0.10.0/24"
	availability_zone = "us-east-2a"
	tags = {
		Name = "subredA"
	}
}

resource "aws_subnet" "redB" {
	vpc_id = "${aws_vpc.kubernetes.id}"
	cidr_block = "10.0.20.0/24"
	availability_zone = "us-east-2b"
	tags = {
		Name = "subredB"
	}
}

resource "aws_subnet" "redC" {
	vpc_id = "${aws_vpc.kubernetes.id}"
	cidr_block = "10.0.30.0/24"
	availability_zone = "us-east-2c"
	tags = {
		Name = "subredC"
	}
}

resource "aws_internet_gateway" "gw" {
	vpc_id = "${aws_vpc.kubernetes.id}"
	tags = {
		Name = "gw-kubernetes"
	}
}

resource "aws_route_table" "ruta" {
  vpc_id = "${aws_vpc.kubernetes.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "ruta_kubernetes"
  }
}

resource "aws_main_route_table_association" "main" {
  vpc_id         = "${aws_vpc.kubernetes.id}"
  route_table_id = "${aws_route_table.ruta.id}"
}

resource "aws_route_table_association" "redA" {
  subnet_id         = "${aws_subnet.redA.id}"
  route_table_id = "${aws_route_table.ruta.id}"
}

resource "aws_route_table_association" "redB" {
  subnet_id         = "${aws_subnet.redB.id}"
  route_table_id = "${aws_route_table.ruta.id}"
}

resource "aws_route_table_association" "redC" {
  subnet_id         = "${aws_subnet.redC.id}"
  route_table_id = "${aws_route_table.ruta.id}"
}