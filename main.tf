resource "aws_rds_cluster" "main" {
  cluster_identifier      = "${var.env}-rds"
  engine                  = var.engine
  engine_version          = var.engine_version
  database_name           = var.database_name
  master_username         = data.aws_ssm_parameter.user.value
  master_password         = data.aws_ssm_parameter.pass.value
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  skip_final_snapshot     = var.skip_final_snapshot
  db_subnet_group_name = aws_docdb_subnet_group.main.name
  kms_key_id = data.aws_kms_key.kms_key.arn
  storage_encrypted = var.storage_encrypted
}


resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = var.no_of_instances
  identifier         = "${var.env}-rds-${count.index}"
  cluster_identifier = aws_rds_cluster.main.id
  instance_class     = var.instance_class
  engine             = aws_rds_cluster.main.engine
  engine_version     = aws_rds_cluster.main.engine_version
}

resource "aws_docdb_subnet_group" "main" {
  name       = "${var.env}-rds-subnet_group"
  subnet_ids = var.subnet_ids

  tags = merge(
    var.tags,
    {
      Name = "${var.env}-subnet-group"
    },
  )
}

