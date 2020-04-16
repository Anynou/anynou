resource "aws_security_group" "kubernetes" {
    name = "kubernetes"
    description = "kubernetes security group"
    vpc_id = "${aws_vpc.kubernetes.id}"


    ingress {
	from_port = "0"
	to_port = "0"
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
	from_port = "0"
	to_port = "0"
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
	    Name = "kubernetes"
    }

}
