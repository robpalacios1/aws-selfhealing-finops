# ====================================================================
# 1. Data lookups
# ====================================================================

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

# ====================================================================
# 2. Launch Template
# ====================================================================

resource "aws_launch_template" "swo_launch_template" {
  name_prefix   = "swo-web-${var.environment}-lt"
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = "t3.small"

  vpc_security_group_ids = [var.security_group_id]
  user_data              = filebase64("${path.module}/../../../scripts/userdata.sh")

  tags = {
    Name        = "${var.environment}-swo-launch-template"
    environment = "${var.environment}"
  }
}

# ====================================================================
# 3. Auto Scaling Group
# ====================================================================

resource "aws_autoscaling_group" "swo_asg" {
  name                = "swo-web-${var.environment}-asg"
  vpc_zone_identifier = var.subnet_id

  desired_capacity = 2
  min_size         = 2
  max_size         = 4

  launch_template {
    id      = aws_launch_template.swo_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }
}