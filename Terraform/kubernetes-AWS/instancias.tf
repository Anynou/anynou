resource "aws_instance" "master" {
	ami = "ami-0d5d9d301c853a04a"
	instance_type = "t3a.micro"
	subnet_id = "${aws_subnet.redA.id}"
	tenancy = "default"
	vpc_security_group_ids = ["${aws_security_group.kubernetes.id}"]
	associate_public_ip_address = true
	private_ip = "10.0.10.10"
	user_data = "${file("kube.sh")}"
	key_name = "prueba"
	tags = {
		Name = "master"
	}
}

resource "aws_instance" "worker1" {
	ami = "ami-0d5d9d301c853a04a"
	instance_type = "t3a.micro"
	subnet_id = "${aws_subnet.redB.id}"
	tenancy = "default"
	vpc_security_group_ids = ["${aws_security_group.kubernetes.id}"]
	associate_public_ip_address = true
	private_ip = "10.0.20.10"
	user_data = "${file("kube.sh")}"
	key_name = "prueba"
	tags = {
		Name = "worker1"
	}
}

resource "aws_instance" "worker2" {
	ami = "ami-0d5d9d301c853a04a"
	instance_type = "t3a.micro"
	subnet_id = "${aws_subnet.redC.id}"
	tenancy = "default"
	vpc_security_group_ids = ["${aws_security_group.kubernetes.id}"]
	associate_public_ip_address = true
	private_ip = "10.0.30.10"
	user_data = "${file("kube.sh")}"
	key_name = "prueba"
	tags = {
		Name = "worker2"
	}
}
