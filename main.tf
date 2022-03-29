terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "qa-read"
  region  = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ac_base.id
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

data "aws_ami" "ac_base" {
     most_recent = true

     filter {
        name   = "name"
        values = ["java-docker-*"]

    }

     # owners = ["034025401910"] # QA env
     owners = ["700709168703"] # Pre-prod
 }
