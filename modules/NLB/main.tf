data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [ var.vpc_id ]
  }

  tags = {
    Tier = "private"
  }
}

resource "aws_lb" "this" {
  name               = "${var.name}-${terraform.workspace}-NLB"
  load_balancer_type = "network"
  subnets            = data.aws_subnets.private.ids
  internal           = true
  
}


resource "aws_lb_listener" "this" {

  load_balancer_arn = aws_lb.this.arn

  protocol          = var.NLB_vars[ "protocol" ]
  port              = var.NLB_vars[ "port" ]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group" "this" {
  name = "${var.name}-${terraform.workspace}-NLBTG"
  port        = var.NLB_vars[ "port" ]
  protocol    = var.NLB_vars[ "protocol" ]
  vpc_id      = var.vpc_id
  
  health_check {
   interval =  var.NLB_vars[ "HC_interval" ]
   healthy_threshold = var.NLB_vars[ "HC_healthy_threshold" ]
   unhealthy_threshold = var.NLB_vars[ "HC_unhealthy_threshold" ]
   protocol = var.NLB_vars[ "protocol" ]
  }

  depends_on = [
    aws_lb.this
  ]

}

resource "aws_lb_target_group_attachment" "this" {

  target_group_arn  = aws_lb_target_group.this.arn
  target_id         = var.db_id
  port              = var.NLB_vars[ "port" ]
}