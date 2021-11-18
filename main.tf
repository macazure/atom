provider "aws" {

    region = "eu-west-2"
    profile = "terraform"
}

resource "aws_s3_bucket" "atomisesec-remote-state" {
  bucket = "atomisesec-remote-state"
  acl    = "private"

}
resource "aws_dynamodb_table" "terraform-state-lock" {
  name             = "terraform-state-locks"
  billing_mode     = "PROVISIONED"
  hash_key         = "LockID"
  read_capacity    = 1
  write_capacity   = 1  
  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  backend "s3" {
    bucket         = "atomisesec-remote-state"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}


 
  

