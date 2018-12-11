region = "us-east-1"
public_key_path = "C:/Users/<userid>/.ssh/id_rsa.pub"
#public_key_path = "~\.ssh\id_rsa.pub"

# This name will be prepended to all resources
name = "test-tfm-aws"

# VPC Variables (ASG needs atleast 2 azs )
vpc_azs = [ "us-east-1a", "us-east-1b" ]
vpc_cidr = "10.0.0.0/16"
vpc_private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
vpc_public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]
vpc_database_subnets = ["10.0.5.0/24", "10.0.6.0/24"]
vpc_enable_nat_gateway = true
vpc_single_nat_gateway = false
vpc_one_nat_gateway_per_az = true

# DB Variables
db_identifier = "tfmawsdb"
db_name = "tfmawsdb"
db_username = "tfmawsdbuserid"
db_password = "tfmawsdbpassword"
#db_allocated_storage = 
db_port = 3306
#db_backup_window = 
db_backup_retention_period = false
#db_maintenance_window = 
db_deletion_protection = false

# App variables
app_port = 80
app_instance_type = "t2.micro"
app_autoscale_min_size = 2
app_autoscale_max_size = 3
#app_elb_health_check_interval = 20
#app_elb_healthy_threshold = 
#app_elb_unhealthy_threshold = 
#app_elb_health_check_timeout = 

# Web Variables
web_port = 80
web_instance_type = "t2.micro"
web_autoscale_min_size = 2
web_autoscale_max_size = 3
#web_elb_health_check_interval = 
#web_elb_healthy_threshold = 
#web_elb_unhealthy_threshold = 
#web_elb_health_check_timeout = 
