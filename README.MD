# 3 Tier AWS Architecture / WEB, WAS, DB

ELB(WEB) -> Web Server(EC2:NGINX) -> ELB(WAS) -> WAS Server (EC2:Tomcat) -> RDS

A Completely Automated Terraform code which needs a terraform.exe and a fresh AWS Account with a Secret and Access keys(saved either in config file or as an environment variable), for more details refer the terraform.bat (Windows) file 

## Terraform init 
AWS modules are auto downloaded from github public repo and are setup , in case there are issues downloading validate if the github public ssh keys are configured with no host keycheck. 

## Terraform variables 
Variables can be overridden by updating terraform.tfvars file

MAC)
public_key_path = "~\.ssh\id_rsa.pub"

Windows)
public_key_path = "C:/Users/<userid>/.ssh/id_rsa.pub"

##Security : 
Only port 80 is open for web (bebhind ELB), which can be changed to any other port (by updating the variables in terraform.tfvars)

## Architecture : 
Design uses ELB for load balancing , and is the only way to access the web page. 

Web EC2 instances (Nginx) are behind Autoscaling groups , terraform variables can be updated to change the instance size / type and min or max count. 

App EC2 instances (PHP with connection to RDS) are behind Autoscaling groups as well and terraform variables can be updated to change the instance size / type and min or max count. 

To test connection with RDS hit the Web elb dns (printed in console at the end of terraform apply) 

##Endpoints :
 ### See WEB info :
 *http://<AWS_WEB_ELB_FQDN>*
 ### See DB connection :
 *http://<AWS_WEB_ELB_FQDN>/connect.php*

 
## Output : 
At completion of terraform apply , you will observer a FQDN of web ELB which is to access the nginx
Output (Infrastructure)
1) VPC 
2) NAT
3) ELB
4) ASG
5) EC2 
6) RDS 
7) Security Groups
8) New Key for Vm's in case you need to ssh (by default ssh is not open , security groups can be updated with port 22 to access the web)
