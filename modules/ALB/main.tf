data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [ var.vpc_id ]
  }

  tags = {
    Tier = "public"
  }
}

resource "aws_lb" "ALB" {
  name               = "${var.name}-${terraform.workspace}-ALB"
  load_balancer_type = "application"
  subnets            = data.aws_subnets.public.ids
  internal           = false
  security_groups    = var.secgroups
  
}

/* 
resource "aws_lb_listener" "this" {

  load_balancer_arn = aws_lb.ALB.arn
  protocol          = var.ALB_vars[ "protocol" ]
  port              = var.ALB_vars[ "port" ]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group" "this" {
    name = "${var.name}-${terraform.workspace}-ALBTG"
    port        = var.ALB_vars[ "port" ]
    protocol = var.ALB_vars[ "protocol" ]
    vpc_id      = var.vpc_id
    deregistration_delay = var.ALB_vars[ "deregistration_delay" ]
    health_check {
        interval =  var.ALB_vars[ "HC_interval" ]
        path = "/"
        healthy_threshold = var.ALB_vars[ "HC_healthy_threshold" ]
        unhealthy_threshold = var.ALB_vars[ "HC_unhealthy_threshold" ]
        timeout = var.ALB_vars[ "HC_timeout" ]
        protocol = var.ALB_vars[ "protocol" ]
    }

    depends_on = [
    aws_lb.ALB
    ]

} */