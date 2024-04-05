resource "aws_security_group" "nfs_sg" {
  name   = "${var.project_prefix}-nfs-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_fsx_ontap_file_system" "file_system" {
  storage_capacity    = 1024
  subnet_ids          = [var.subnet_id]
  preferred_subnet_id = var.subnet_id
  deployment_type     = "SINGLE_AZ_1"
  throughput_capacity = 128
  security_group_ids  = [aws_security_group.nfs_sg.id]
  fsx_admin_password  = var.fsx_admin_password

  tags = {
    Name = "${var.project_prefix}-fsxn"
  }

  timeouts {
    create = "60m"
    update = "60m"
  }
}

resource "aws_fsx_ontap_storage_virtual_machine" "svm" {
  file_system_id = aws_fsx_ontap_file_system.file_system.id
  name           = "${var.project_prefix}-svm"
}

resource "aws_fsx_ontap_volume" "volume" {
  name                       = "vol"
  junction_path              = "/vol1"
  size_in_megabytes          = 1048576
  storage_efficiency_enabled = true
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.svm.id

  lifecycle {
    ignore_changes = [
      tiering_policy[0].cooling_period
    ]
  }
}
