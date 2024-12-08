---
tags: [AWS, aws-lambda]
---

# Accessing secrets from a Lambda

If a Lambda connects to a database or calls an API, it is going need access to
authentication tokens/passwords.

You obviously should not store these in your code. Instead you should store them
in AWS Secrets Manager and access them via the `aws-sdk` in your Lambda
function.

In order for your function to be able to access the secrets however, it will
need to be given permission. While the Lambda is not itself a "user" it does
have an identity in the form of its IAM role. This is disclosed by its ARN.

To allow the Lambda to access the secret you should add a resource permission on
the secret that designates the Lambda.

> When you create a Lambda function, you specify an IAM role that AWS Lambda can
> assume to execute the function on your behalf. This role is referred to as the
> execution role. The execution role grants the function the necessary
> permissions to call other AWS services, access resources, and perform other
> operations.

Here is an example of a resource permission giving access to a Lambda:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::885135949562:role/pocket-api-lambda-QueryPocketFunctionRole-GY5ZN3RW31KE"
      },
      "Action": "secretsmanager:GetSecretValue",
      "Resource": "arn:aws:secretsmanager:eu-west-2:885135949562:secret:pocket-api-credentials-wEvQMI"
    }
  ]
}
```

See
[Fetch from Secrets Manager](Fetch_from_Secrets_Manager.md)
for a code example of retrieving a value from Secrets Manager.
