locals {
  instance_type = "t2.nano"
  aws_common_tag = {
    Name = "mini-projet"
  }
  size = 10
  AZ        = "us-east-1a"  
  key_pair_key_name = "my-dynamic-key"  
}