resource "aws_dynamodb_table" "trial-dynamo" {
    name = "terraform-dynamo"
    hash_key = "Employee-no"
    billing_mode = "PAY_PER_REQUEST" # Default = provisioned (It will have write_capacity and read_capacity)
    
    attribute {
      name = "Employee-no" #partition-key
      type = "S"
    }
    
    tags = {
        Name = "Terrafom developed"
        Env = "Terraform test"
    }
  
}

resource "aws_dynamodb_table_item" "employee-list" {
    table_name = aws_dynamodb_table.trial-dynamo.name
    hash_key = aws_dynamodb_table.trial-dynamo.hash_key
    item = file("item.json")
}
