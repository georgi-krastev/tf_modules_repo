# CIDR ranges for VPC and subnets ------------------

variable "vpc_cidr_block" {
 # default = "172.16.0.0/16"
 type = string
}
variable "pub_sub_01_cidr" {
  # default = "172.16.1.0/24"
  type = string
}

variable "pub_sub_02_cidr" {
  # default = "172.16.3.0/24"
  type = string
}

variable "priv_sub_03_cidr" {
  # default = "172.16.4.0/24"
  type = string
}

variable "priv_sub_04_cidr" {
  # default = "172.16.5.0/24"
  type = string
}

# Availability Zones ---------------------------
variable "avail_zone_1a" {
  # default = "eu-west-1a"
  type = string
}

variable "avail_zone_1b" {
  # default = "eu-west-1b"
  type = string
}

# CIDR block for routing tables ------------------
variable "rt_cidr_block" {
  # default = "0.0.0.0/0"
  type = string
}

##### EC2 Image ID ------------------------------------
variable "ec2_image_id" {
  # default = "ami-061cf30a139d73d7a"
  type = string
}

##### EC2 Instance Type ------------------------------------
variable "ec2_instance_type" {
  # default = "t2.micro"
  type = string
}

##### SSM Policy ARN ----------
variable "ssm_policy_arn" {
  # default = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  type = string
}

##### CW Policy ARN ----------
variable "cloud_watch_policy_arn" {
  # default = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
  type = string
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}

# # Specific Public IP 

# variable "my_public_ip" {
#   default = ["91.211.97.132/32"]
  
# }