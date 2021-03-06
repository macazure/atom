provider "aws" {

    region = "eu-west-2"
    profile = "terraform"
}

resource "aws_s3_bucket" "macbucket" {
  bucket = "joomla-pm"
  acl    = "private"

  tags = {
    Name        = "joomla-pm"
  }
}
  resource "aws_dynamodb_table" "jooml_locks" {
  name         = "joomla-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  
  attribute {
    name = "LockID"
    type = "S"
  }
  }

  terraform {
  backend "s3" {
    bucket         = "joomla-pm"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "joomla-running-locks"
    encrypt        = true
  }
}


 
  

