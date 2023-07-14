
module "vpc" {
  source = "./modules/VPC"

  vpc={
    vpc-cidr=var.vpc["vpc-cidr"]
    public-subnets-cidr  = var.vpc["public-subnets-cidr"]
    private-subnets-cidr = var.vpc["private-subnets-cidr"]

}
  name = var.name
}
 
module "secgroups" {
  source = "./modules/SecGroups"

  vpc_id = module.vpc.vpc_id
  server-ingress = var.server-ingress
  DB-ingress = var.DB-ingress
  ALB-ingress = var.ALB-ingress
  depends_on = [
    module.vpc
  ]
}


module "ssmrole" {
  source = "./modules/ssm_role"
  name = var.name
}

/* module "ec2-public" {
  source = "./modules/Ec2"

  instance_ami = var.instance_ami
  instance_type = var.instance_type
  subnet = module.vpc.subnet-public-1
  pub_key = var.key
  secgroups = ["${module.secgroups.WebServer-SG-ID }"]
  SSMProfileName = module.ssmrole.SSMProfile
  userdatafilepath = var.userdatafilepath
  postfix = "Public"
  name = var.name
  depends_on = [
    module.ssmrole,
    module.secgroups
  ]
} */

/* module "ec2-public2" {
  source = "./modules/Ec2"

  instance_ami = var.instance_ami
  instance_type = var.instance_type
  subnet = module.vpc.subnet-private-1
  pub_key = var.key
  secgroups = ["${module.secgroups.WebServer-SG-ID }"]
  SSMProfileName = module.ssmrole.SSMProfile
  userdatafilepath = var.userdatafilepath
  postfix = "Private"
  name = var.name
  depends_on = [
    module.ssmrole,
    module.secgroups
  ]
}
 
module "ec2-bastion-3" {
  source = "./modules/Ec2"

  instance_ami = var.instance_ami
  instance_type = var.instance_type
  subnet = module.vpc.subnet-public-1
  pub_key = var.key
  secgroups = ["${module.secgroups.WebServer-SG-ID }"]
  SSMProfileName = module.ssmrole.SSMProfile
  userdatafilepath = var.userdatafilepath
  postfix = "Bastion"
  name = var.name
  depends_on = [
    module.ssmrole,
    module.secgroups
  ]
} */

/* module "ec2-public-3" {
  source = "./modules/Ec2"

  instance_ami = var.instance_ami
  instance_type = "t2.micro"
  subnet = module.vpc.subnet-public-1
  pub_key = var.key
  secgroups = ["${module.secgroups.WebServer-SG-ID }"]
  SSMProfileName = module.ssmrole.SSMProfile
  userdatafilepath = var.userdatafilepath
  postfix = "jenkins-EC2"

  depends_on = [
    module.ssmrole,
    module.secgroups
  ]
}  */

/*
module "database" {
  source = "./modules/Ec2"

  instance_ami = var.instance_ami
  instance_type = var.instance_type
  subnet = module.vpc.subnet-private-1
  pub_key = var.key
  secgroups = ["${module.secgroups.DB-SG-ID}"]
  SSMProfileName = module.ssmrole.SSMProfile
  userdatafilepath = var.dbuserdata
  postfix = "DB"
  
  depends_on = [
    module.ssmrole,
    module.secgroups
  ]
}

module "NLB" {
  source = "./modules/NLB"

  vpc_id = module.vpc.vpc_id
  db_id  = module.database.id

  depends_on = [
    module.database 
  ]
  
}
*/
/*
module "ALB" {
  source = "./modules/ALB"

  vpc_id = module.vpc.vpc_id
  secgroups = [ "${ module.secgroups.ALB-SG-ID }" ]
  
  ALB_vars = {
    HC_healthy_threshold = var.ALB_vars[ "HC_healthy_threshold" ]
    HC_interval = var.ALB_vars["HC_interval"]
    HC_timeout = var.ALB_vars["HC_timeout"]
    HC_unhealthy_threshold = var.ALB_vars["HC_unhealthy_threshold"]
    deregistration_delay = var.ALB_vars[ "deregistration_delay" ]
    protocol = var.ALB_vars[ "protocol" ]
    port = var.ALB_vars[ "port" ]
  }
  name="primary-ALB1"
  depends_on = [
    module.secgroups
  ]
} 
module "ALB2" {
  source = "./modules/ALB"

  vpc_id = module.vpc.vpc_id
  secgroups = [ "${ module.secgroups.ALB-SG-ID }" ]
  
  ALB_vars = {
    HC_healthy_threshold = var.ALB_vars[ "HC_healthy_threshold" ]
    HC_interval = var.ALB_vars["HC_interval"]
    HC_timeout = var.ALB_vars["HC_timeout"]
    HC_unhealthy_threshold = var.ALB_vars["HC_unhealthy_threshold"]
    deregistration_delay = var.ALB_vars[ "deregistration_delay" ]
    protocol = var.ALB_vars[ "protocol" ]
    port = var.ALB_vars[ "port" ]
  }
  name="primary-ALB2"  
  depends_on = [
    module.secgroups
  ]
} 
module "ALB3" {
  source = "./modules/ALB"

  vpc_id = module.vpc.vpc_id
  secgroups = [ "${ module.secgroups.ALB-SG-ID }" ]
  
  ALB_vars = {
    HC_healthy_threshold = var.ALB_vars[ "HC_healthy_threshold" ]
    HC_interval = var.ALB_vars["HC_interval"]
    HC_timeout = var.ALB_vars["HC_timeout"]
    HC_unhealthy_threshold = var.ALB_vars["HC_unhealthy_threshold"]
    deregistration_delay = var.ALB_vars[ "deregistration_delay" ]
    protocol = var.ALB_vars[ "protocol" ]
    port = var.ALB_vars[ "port" ]
  }
  name="primary-ALB3"  
  depends_on = [
    module.secgroups
  ]
} 

module "LaunchTemplate" {
  source = "./modules/LaunchTemplate"

  instance_ami = var.instance_ami
  instance_type = var.instance_type
  pub_key = var.key
  secgroups = ["${module.secgroups.WebServer-SG-ID}"]
  SSMProfileName = module.ssmrole.SSMProfile
  userdatafilepath = var.webuserdata
  postfix = "LT"
  NLBDNS = module.NLB.NLB-DNS

  depends_on = [
    module.NLB,
    module.ssmrole
  ]
}

module "ASG" {
  source = "./modules/ASG"

  LT_id =  module.LaunchTemplate.id 
  vpc_id = module.vpc.vpc_id 
  min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired_capacity
  target_group_arns = [ module.ALB.TGARN ]

  depends_on = [
    module.LaunchTemplate
  ]
} */