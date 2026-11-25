# --- Policy (built from the variable) ---
data "aws_iam_policy_document" "s3_read" {
  statement {
    sid       = "S3ReadOnly"
    effect    = "Allow"
    actions   = var.s3_read_policy.actions
    resources = var.s3_read_policy.resources
  }
}

resource "aws_iam_policy" "s3_read" {
  name        = var.policy_name
  description = "Read-only access to S3"
  policy      = data.aws_iam_policy_document.s3_read.json
  tags        = var.tags
}

# --- Group + attachment ---
resource "aws_iam_group" "s3_readers" {
  name = var.group_name
}

resource "aws_iam_group_policy_attachment" "s3_read" {
  group      = aws_iam_group.s3_readers.name
  policy_arn = aws_iam_policy.s3_read.arn
}

# --- Users ---
resource "aws_iam_user" "this" {
  for_each      = var.user_names
  name          = each.value
  force_destroy = true
  tags          = var.tags
}

resource "aws_iam_user_group_membership" "this" {
  for_each = aws_iam_user.this
  user     = each.value.name
  groups   = [aws_iam_group.s3_readers.name]
}

# --- Access keys (optional, for CLI testing) ---
/*resource "aws_iam_access_key" "this" {
  for_each = var.create_access_keys ? aws_iam_user.this : {}
  user     = each.value.name
}*/
