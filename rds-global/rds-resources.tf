data "terraform_remote_state" "site" {
  //???
}

resource "aws_security_group" "rds-mysql-db" {

  name = "workshop_rds"
  description = "sg for workshop rds"
  vpc_id = data.terraform_remote_state.site.outputs.vpc_id


  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "rds-db-default-group" {
//???
}

resource "aws_db_instance" "rds-db" {
  //???
  skip_final_snapshot = var.skip_final_snapshot
}