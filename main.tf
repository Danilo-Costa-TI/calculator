terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.53.0"
    }
  }
}
#permite acessar conta de user aws criada
provider "aws" {
  region     = "us-west-1"
  access_key = "AKIATUWXMIS54XE4D2FJ"
  secret_key = "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"
}
#criando bucket e dando nome
resource "aws_s3_bucket" "b" {
  bucket = "teste-site"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
#definindo como site statico
resource "aws_s3_bucket_acl" "b" {
  bucket = aws_s3_bucket.b.id
  acl    = "public-read"
}

  resource "aws_s3_bucket_website_configuration" "b" {
  bucket = aws_s3_bucket.b.bucket

  index_document {
    suffix = "index.html"
  }

}
#Definindo liberacao policy
resource "aws_s3_bucket_policy" "b" {
  bucket = aws_s3_bucket.b.id

  policy = <<POLICY
{
   "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Statement1",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::teste-site/*"
        }
    ]
}
POLICY
}
#Fazendo upload dos arquivos


