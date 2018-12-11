resource "aws_security_group" "web" {
  name = "${format("%s-web-sg", var.name)}"

  vpc_id = "${module.vpc.vpc_id}"

  ingress {
    from_port   = "${var.web_port}"
    to_port     = "${var.web_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH is locked down for security only port 80 is open
  #ingress {
  #  from_port   = "22"
  #  to_port     = "22"
  #  protocol    = "tcp"
  #  cidr_blocks = ["0.0.0.0/0"]
  #}

  egress {
    from_port   = "0"
    to_port     = "65535"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Group = "${var.name}"
  }

}

#TODO REMOVE
resource "aws_key_pair" "web-key" {
  key_name = "web-key"
  public_key = "${ file(var.public_key_path) }"

}

resource "aws_launch_configuration" "web" {
  image_id        = "${data.aws_ami.amazon_linux.id}"
  instance_type   = "${var.web_instance_type}"
  security_groups = ["${aws_security_group.web.id}"]

  key_name = "web-key"
  name_prefix = "${var.name}-web-vm-"

  user_data = <<-EOF
              #!/bin/bash  
              ## Install NGINX
              sudo yum update -y 
              sudo yum install -y nginx  
              sudo echo "
              worker_processes 1;
              error_log  /var/log/nginx/error.log warn;
              pid /var/run/nginx.pid;

              events {
                worker_connections 1024; # increase if you have lots of clients
                accept_mutex off; # set to 'on' if nginx worker_processes > 1
                # 'use epoll;' to enable for Linux 2.6+
                # 'use kqueue;' to enable for FreeBSD, OSX
              }

              http {
                include mime.types;
                # fallback in case we can't determine a type
                default_type application/octet-stream;
                access_log /var/log/nginx/access.log combined;
                sendfile on;
              server {
                  listen 80;
                  location / {
                  proxy_pass http://${module.elb_app.this_elb_dns_name} ;
                  }
              }
              }" | sudo tee /etc/nginx/nginx.conf > /dev/null 2>&1
              # configure and start nginx
              sudo service nginx start
              EOF

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "web" {
  launch_configuration = "${aws_launch_configuration.web.id}"

  vpc_zone_identifier = ["${module.vpc.public_subnets}"]

  load_balancers    = ["${module.elb_web.this_elb_name}"]
  health_check_type = "EC2"

  min_size = "${var.web_autoscale_min_size}"
  max_size = "${var.web_autoscale_max_size}"

  tags {
    key = "Group" 
    value = "${var.name}"
    propagate_at_launch = true
  }

}

variable "web_port" {
  description = "The port on which the web servers listen for connections"
  default = 80
}

variable "web_instance_type" {
  description = "The EC2 instance type for the web servers"
  default = "t2.micro"
}

variable "web_autoscale_min_size" {
  description = "The fewest amount of EC2 instances to start"
  default = 2
}

variable "web_autoscale_max_size" {
  description = "The largest amount of EC2 instances to start"
  default = 3
}

