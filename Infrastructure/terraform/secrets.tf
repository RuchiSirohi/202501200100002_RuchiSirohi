# ==========================================
# Generate a Random Database Password
# ==========================================

resource "random_password" "db_password" {
  length           = 20
  special          = true
  override_special = "!#$%&*()-_=+"
}

# ==========================================
# Store Database Username in Parameter Store
# ==========================================

resource "aws_ssm_parameter" "db_username" {
  name  = "/cloudnotes/database/username"
  type  = "String"
  value = "cloudnotes_user"

  tags = {
    Name = "cloudnotes-db-username"
  }
}

# ==========================================
# Store Database Password Securely
# ==========================================

resource "aws_ssm_parameter" "db_password" {
  name = "/cloudnotes/database/password"

  type = "SecureString"

  value = random_password.db_password.result

  tags = {
    Name = "cloudnotes-db-password"
  }
}
