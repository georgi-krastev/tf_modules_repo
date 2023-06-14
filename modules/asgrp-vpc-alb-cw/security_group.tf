# Create a Security Group Load Balancer ----------------------------------------
resource "aws_security_group" "allow_http_sg" {
  name        = "allow-http-sec-group"
  description = "Allow HTTP traffic to VPC"
  vpc_id      = aws_vpc.my_vpc_01.id

  ingress {
    description      = "HTTP traffic to VPC through LB"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["91.211.97.132/32"]
  }

  egress {
    description = "HTTP traffic from VPC through LB"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

# Create a Security Group for EC2 Launch Template -----------------------------------------------------
resource "aws_security_group" "ec2_sec_grp_01" {
  name        = "ec2-sec-grp-01"
  description = "Allow HTTP inbound traffic from LB to EC2 instances"
  vpc_id      = aws_vpc.my_vpc_01.id

  ingress {
    description      = "Traffic from http sec group"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    security_groups = [aws_security_group.allow_http_sg.id] 
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}