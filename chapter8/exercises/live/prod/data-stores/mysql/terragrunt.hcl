terraform {
  source = "../../../../modules//data-stores/mysql"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  db_name     = "example_prod"
  db_username = "admin"
  db_password = "KLaasje_123"

  # Set the password using the TF_VAR_db_password environment variable
}
