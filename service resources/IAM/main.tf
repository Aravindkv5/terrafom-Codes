

resource "aws_iam_user" "username" {
name = "test-terraform" # test IAM user will be created.
tags = {
    Description = "created through terraform"
} 
}

resource "aws_iam_policy" "testpolicy" {
    name = "policy-test-terraform"
    description = "Test policy through terraform"
    policy = file("policy.json")
}


resource "aws_iam_user_policy_attachment" "test-policy-attachment" {
    user =  aws_iam_user.username.name
    policy_arn = aws_iam_policy.testpolicy.arn
  
}

#Check below link
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user
#need to check random variables in terraform to find out whetehr we can create a random password and put it in output file. 
