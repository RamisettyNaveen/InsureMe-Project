provider "aws" {
  region     = "ap-south-1"
}

resource "aws_instance" "sample_machine"{
    ami = "ami-0a1b648e2cd533174"
    instance_type = "t2.micro"
        tags = {Name = "HTTPS SERVER"}
}
