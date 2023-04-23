variable "env" {}
variable "engine" {}
variable "database_name" {
  default = "Test"
}
variable "engine_version" {}
variable "backup_retention_period" {}
variable "preferred_backup_window" {}
variable "no_of_instances" {}
variable "instance_class" {}
variable "tags" {}
variable "subnet_ids" {}
variable "storage_encrypted" {
  default = true
}
variable "skip_final_snapshot" {}

