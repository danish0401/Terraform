variable "name" {
  default = "danish"
  type    = string
}

variable "vpc_id" {
  type = string
  default = ""
}
variable "LT_id" {
  default = ""
  type    = string
}

variable "LTversion" {
    type = string
    default = "$Latest"
}

variable "min_size" {
    type = number
    default = 1
}

variable "max_size" {
    type = number
    default = 2
}

variable "desired_capacity" {
    type = number
    default = 1
}

variable "default_cooldown" {
    type = number
    default = 180
}

variable "target_group_arns" {
    type = list(string)
    default = [ "" ]
}

variable "health_check_type" {
    type = string
    default = "ELB"
}

variable "health_check_grace_period" {
    type = number
    default = 180
}

variable "email" {
    type = string
    default = "danish.hafeez76@gmail.com"
}

variable "step_adjustments_up" {
    type = map
    default = {
      0 = [ 0.0, 10.0 ]
      10 = [ 10.0, 20.0 ]
      30 = [ 20 , null ]
    }
  
}

variable "step_adjustments_down" {
    type = map
    default = {
        0 = [ -10.0 , 0.0 ]
      -10 = [ -20.0, -10.0 ]
      -30 = [ null , -20.0 ]
    }  
}

variable "ASG_Autoscaling_policy" {
    type = object({
        adjustment_type = string
        policy_type = string
        metric_aggregation_type = string
    })
    default = {
      adjustment_type = "PercentChangeInCapacity"
      metric_aggregation_type = "Maximum"
      policy_type = "StepScaling"
    }
}

variable "CW_alarm_high" {
    type = object({
        comparison_operator = string
        evaluation_periods  = string
        metric_name         = string
        namespace           = string
        period              = string
        statistic           = string
        threshold           = string
    })
    default = {
        comparison_operator = "GreaterThanOrEqualToThreshold"
        evaluation_periods  = "2"
        metric_name         = "CPUUtilization"
        namespace           = "AWS/EC2"
        period              = "60"
        statistic           = "Maximum"
        threshold           = "60"
    }
  
}

variable "CW_alarm_low" {
    type = object({
        comparison_operator = string
        evaluation_periods  = string
        metric_name         = string
        namespace           = string
        period              = string
        statistic           = string
        threshold           = string
    })
    default = {
        comparison_operator = "LessThanOrEqualToThreshold"
        evaluation_periods  = "2"
        metric_name         = "CPUUtilization"
        namespace           = "AWS/EC2"
        period              = "60"
        statistic           = "Maximum"
        threshold           = "40"
    }
  
}