terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  backend "s3" {
    bucket = "stevepop-tf-backend"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "s3Bucket" {
  bucket = "cloudcasts-stevepop"
  acl    = "public-read"

  policy = <<EOF
     {
       "id" : "MakePublic",
       "version" : "2012-10-17",
       "statement" : [
       {
         "action" : [
             "s3:GetObject"
          ],
         "effect" : "Allow",
         "resource" : "arn:aws:s3:::[BUCKET_NAME_HERE]/*",
         "principal" : "*"
      }
    ]
  }
  EOF
  website {
    index_document = "index.html"
  }
}
