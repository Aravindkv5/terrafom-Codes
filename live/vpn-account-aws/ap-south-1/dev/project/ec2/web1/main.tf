module "ec2" {
    source = "../../../../../../../modules//services/ec2"
    instance_type = "t2.micro"

}