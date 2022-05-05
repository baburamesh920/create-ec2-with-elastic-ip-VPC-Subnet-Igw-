resource "aws_vpc" "default" {
  
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  
  tags = {
    Terraform   = "true"
    name        = "VPC"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.default.id}"
}

resource "aws_subnet" "tf_test_subnet" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true

  depends_on = ["aws_internet_gateway.gw"]
}

resource "aws_instance" "foo" {

  ami                       = "ami-00c90dbdc12232b58"
  instance_type             = "t2.micro"
#   disable_api_termination   = true
  monitoring                = true
  tags = {
    Terraform   = "true"
    name        = "Ec2-instance-ramesh"
  }


  private_ip = "10.0.0.12"
  subnet_id  = "${aws_subnet.tf_test_subnet.id}"
   
}



resource "aws_eip" "bar" {
 
  instance                  = "${aws_instance.foo.id}"
  associate_with_private_ip = "10.0.0.12"
  depends_on                = ["aws_internet_gateway.gw"]
  public_ipv4_pool          = "amazon"
   vpc                      = true

  tags = {
    Terraform   = "true"
    name        = "Eip-ramesh"
  }
}
