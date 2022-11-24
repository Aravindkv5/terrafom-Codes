resource "aws_launch_template" "terraform-test-lt" {
  name = "terraform-test"

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 8
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  #cpu_options {
    #core_count       = 4
    #threads_per_core = 2
  #}

  credit_specification {
    cpu_credits = "standard"
  }

  ebs_optimized = false

  image_id = var.ami

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.micro"

  key_name = var.key_name

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = true
  }

   placement {
    availability_zone = var.availability_zone
  }

  vpc_security_group_ids = var.security_groups

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }

  user_data = filebase64("${path.module}/userdata.tpl")

  update_default_version = true
}

resource "aws_autoscaling_group" "asg-test" {
  name                 = "terraform-asg-example"
  availability_zones = [var.availability_zone]
  min_size             = 1
  max_size             = 1

  launch_template {
    id = aws_launch_template.terraform-test-lt.id
    
  }
  
  

  lifecycle {
    create_before_destroy = true
  }
}
#name was empty in created ec2 instance and output was instance ID
#need to check on how to provide keypair
