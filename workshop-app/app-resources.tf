
data "terraform_remote_state" "site" {
  backend = "s3"
  config = {
    bucket = var.terraform_bucket
    key = var.site_module_state_path
    region = //"us-east-2"
  }
}

resource "aws_launch_configuration" "workshop-app_lc" {
  user_data = templatefile("${path.module}/templates/project-app.cloudinit", {web-app = var.web-app}
   lifecycle {  # This is necessary to make terraform launch configurations work with autoscaling groups
    create_before_destroy = true
  }
  security_groups = [aws_security_group.workshop-app.id]
  name_prefix = "${var.cluster_name}_lc"
  enable_monitoring = false

  image_id = var.ami
  instance_type = var.instance_type
  key_name = data.terraform_remote_state.site.outputs.admin_key_name
  //??? complete the missing attribute
  }

resource "aws_autoscaling_group" "workshop-app_asg" {
  name = "${var.cluster_name}_asg"
  launch_configuration = "${aws_launch_configuration.workshop-app_lc.name}"
  max_size = //???
  min_size = //???
  desired_capacity = //???
  vpc_zone_identifier = element(data.terraform_remote_state.site.outputs.public_subnets, 0)

  load_balancers = [ aws_elb.workshop-app.name ]

  tag {
    key = "Name"
    value = var.cluster_name
    propagate_at_launch = true
  }

  tag {
    key = "Team"
    value = "Workshop"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "workshop-app_lb" {

  name = "${var.cluster_name}-lb"
  description = "${var.cluster_name}-lb"
  vpc_id = data.terraform_remote_state.site.outputs.vpc_id


  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "workshop-app_client" {
  
  lifecycle {  
    create_before_destroy = true
  }

  name = "${var.cluster_name}_client"
  description = "sg for ${var.cluster_name} app clients"
  vpc_id = data.terraform_remote_state.site.outputs.vpc_id

}


resource "aws_security_group" "workshop-app" {
    //??? complete the missing attributes
  vpc_id = data.terraform_remote_state.site.outputs.vpc_id

  lifecycle {  
    create_before_destroy = true
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  name = "${var.cluster_name}_workshop_app"
  description = "sg for ${var.cluster_name} workshop app"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.workshop-app_client.id]
  }
  
}

resource "aws_elb" "workshop-app" {
  name = "${var.cluster_name}-lb"
  listener {
    instance_port = 80
    instance_protocol = "HTTP"
    lb_port = 8080
    lb_protocol = "HTTP"
  }

  subnets = element(data.terraform_remote_state.site.outputs.public_subnets, 0)
  security_groups = [ /* ???*/, /* ???*/ ]

  //??? complete the missing attributes

}