
provider "aws" {
  region = var.region
}

module "backup" {
  source                = "cloudposse/backup/aws"
  name                  = "daily_backup"
  labels_as_tags        = []
  backup_resources      = []

  selection_tags = [{
    type  = "STRINGEQUALS"
    key   = "foo"
    value = "bar"
  }]

  tags = {
    Owner       = "devops"
    Environment = "prod"
    Terraform   = true
  }
  schedule              = "cron(0/60 * * * ? *)"
  start_window          = 60
  completion_window     = 120
  cold_storage_after    = 30
  delete_after          = 120
  iam_role_enabled      = "true"
  destination_vault_arn = "arn:aws:backup:eu-west-1:897086669335:backup-vault:Default"
  kms_key_arn           = "arn:aws:kms:eu-west-1:897086669335:key/b90a0aa4-7b69-48b1-8cfd-917f43bdd802"
  vault_enabled         = true
}


/*
resource "aws_cloudwatch_dashboard" "backup-dash" {
  dashboard_name = "aws-backup-dashboard"
  dashboard_body = <<EOF
  {
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "NumberOfBackupJobsCreated",
            "NumberOfBackupJobsPending",
            "NumberOfBackupJobsAborted",
            "NumberOfBackupJobsCompleted",
            "NumberOfBackupJobsFailed",
            "NumberOfCopyJobsCreated",
            "NumberOfCopyJobsRunning",
            "NumberOfCopyJobsCompleted",
            "NumberOfCopyJobsFailed",
            "NumberOfRestoreJobsRunning"


          ]
        ],
        "period": 300,
        "stat": "Average",
        "region": "eu-west-1",
        "title": "AWS Backup metrics"
      }
    },
    {
      "type": "text",
      "x": 0,
      "y": 7,
      "width": 3,
      "height": 3,
      "properties": {
        "markdown": "Hello world"
      }
    }
  ]
}
EOF

}

*/
