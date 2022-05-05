module "ec2_instance" {
   source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  # key_name               = "user1"
  # vpc_security_group_ids = ["sg-12345678"]
  # subnet_id              = "subnet-eddcdzz4"
  name                    = "single-instance"
  ami                     = "ami-00c90dbdc12232b58"
  instance_type           = "t2.micro"
  disable_api_termination = true
  monitoring              = true


  tags = {
    Terraform   = "true"
    Environment = "dev"
  }



}