locals {
  instance_type = "t2.nano"
  aws_common_tag = {
    Name = "mini-projet"
  }
  size = 10
  AZ        = "us-east-1a"  
  region = "us-east-1"
  key_pair_key_name = "my-dynamic-key"  
}