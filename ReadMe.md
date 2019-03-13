# Repro of Aurora update limitations

As mentioned [here](https://github.com/cfn-modules/rds-aurora-serverless/issues/3). When updating an Aurora stack using @cfn-modules/rds-aurora-serverless, the following properties throw errors if present in the template
* Port
* PreferredBackupWindow
* PreferredMaintenanceWindow

This is an attempt at showing a repro of the issue. To run the stack configure the aws cli and run the `deploy.sh` file.