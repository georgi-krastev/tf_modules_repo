module "ec2_template" {
  source = "./modules/asgrp-vpc-alb-cw"

  ec2_image_id = "ami-061cf30a139d73d7a"
  ec2_instance_type = "t2.micro"
  
  vpc_cidr_block = "172.16.0.0/16"
  pub_sub_01_cidr = "172.16.1.0/24"
  pub_sub_02_cidr = "172.16.3.0/24"
  priv_sub_03_cidr = "172.16.4.0/24"
  priv_sub_04_cidr = "172.16.5.0/24"
  avail_zone_1a = "eu-west-1a"
  avail_zone_1b = "eu-west-1b"
  rt_cidr_block = "0.0.0.0/0"
  ssm_policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  cloud_watch_policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}