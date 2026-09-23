# ====================================================================
# 1. IAM Role for Lambda Function
# ====================================================================

resource "aws_iam_role" "finops_lambda_role" {
    name = "${var.environment}-finops_ec2_autostop_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service = "lambda.amazonaws.com"
                }
            }
        ]
    })
    tags = {
        Name        = "${var.environment}-finops-lambda-role"
        environment = "${var.environment}"
    }
}

# ====================================================================
# 2. IAM Policy for Lambda Function
# ====================================================================

resource "aws_iam_policy" "finops_lambda_policy" {
    name = "${var.environment}-finops_ec2_autostop_policy"
    description = "least priviledge for FinOps ec2 autostop"
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Action = [
                    "ec2:DescribeInstances",
                    "ec2:StopInstances"
                ]
                Resource = "*"
            },
            {
                Effect = "Allow"
                Action = [
                    "logs:CreateLogGroup",
                    "logs:CreateLogStream",
                    "logs:PutLogEvents"
                ]
                Resource = "arn:aws:logs:*:*:*"
            }
        ]
    })
    tags = {
        Name        = "${var.environment}-finops-lambda-policy"
        environment = "${var.environment}"
    }
}

# ====================================================================
# 3. Attach Policy to Role
# ====================================================================

resource "aws_iam_role_policy_attachment" "finops_lambda_policy_attachment" {
    role       = aws_iam_role.finops_lambda_role.name
    policy_arn = aws_iam_policy.finops_lambda_policy.arn
}

# ====================================================================
# 4. Compress Python automatically
# ====================================================================

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/../../../scripts/lambda_function.py"
  output_path = "${path.module}/lambda_function.zip"
}

# ====================================================================
# 5. Create Lambda Function
# ====================================================================

resource "aws_lambda_function" "finops_ec2_stopper" {
    filename      = data.archive_file.lambda_zip.output_path
    function_name = "FinOps-EC2-AutoStop"
    role          = aws_iam_role.finops_lambda_role.arn
    handler       = "lambda_function.lambda_handler"
    runtime       = "python3.9"
    timeout       = 15

    source_code_hash = data.archive_file.lambda_zip.output_base64sha256

    tags = {
        Name        = "${var.environment}-finops-lambda"
        environment = "${var.environment}"
    }
}