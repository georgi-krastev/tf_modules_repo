resource "aws_launch_template" "my_ec2_template" {
  name_prefix            = "terraform"
  image_id               = var.ec2_image_id
  instance_type          = var.ec2_instance_type
  update_default_version = true
  vpc_security_group_ids = [aws_security_group.ec2_sec_grp_01.id]

  # Attach role to EC2 instance
  iam_instance_profile {
    name = aws_iam_instance_profile.iam_instance_profile.name
   }
 
   
  user_data = base64encode(
    <<-EOF
    #!/bin/bash
    amazon-linux-extras install -y nginx1
    systemctl enable nginx --now
    sudo amazon-linux-extras install epel -y
    sudo yum install stress -y
    EOF
  )
}
# Autoscaling group --------------
resource "aws_autoscaling_group" "my_ec2_asgrp" {
  desired_capacity   = 2
  max_size           = 4
  min_size           = 1
  vpc_zone_identifier = [aws_subnet.private_subnet_03.id, aws_subnet.private_subnet_04.id]
  target_group_arns = [aws_lb_target_group.alb_target.arn]

  launch_template {
    id      = aws_launch_template.my_ec2_template.id
    version = "$Latest"
  }

    tag {
      key = "Name"
      value = "auto-scaled-instances"
      propagate_at_launch = true
    }

  #   tag {
  #   key                 = "Name"
  #   value               = "my-instance-${count.index + 1}"
  #   propagate_at_launch = true
  # }
}

# Create Auto Scale Policy -------------------------------------------
resource "aws_autoscaling_policy" "autoscale_policy" {
  name                   = "auto-scale-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.my_ec2_asgrp.name
}

# Attach Policy ---------------------------------------------------------------
resource "aws_autoscaling_attachment" "asg_attachment_lb" {
  autoscaling_group_name = aws_autoscaling_group.my_ec2_asgrp.id
  lb_target_group_arn = aws_lb_target_group.alb_target.arn
}

# Cloudwatch config -----------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "cpu_util_alm" {
  alarm_name                = "terraform-test-cpuutil"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 60
  statistic                 = "Average"
  threshold                 = 30
  alarm_description         = "This metric monitors ec2 cpu utilization"
  alarm_actions = [aws_autoscaling_policy.autoscale_policy.arn]
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.my_ec2_asgrp.name
  }
}