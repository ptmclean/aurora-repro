#!/bin/bash
S3_CLOUDFORMATION_BUCKET="mctest-cloudformation-templates"
STACK_NAME="Test-Aurora"
REGION="ap-southeast-2"

echo "Staring deployment of $STACK_NAME..."

mkdir -p packaged

if aws s3api head-bucket --bucket $S3_CLOUDFORMATION_BUCKET 2>/dev/null; then
    echo "$S3_CLOUDFORMATION_BUCKET bucket creation skipped"
else
    aws s3 mb s3://$S3_CLOUDFORMATION_BUCKET
fi

npm i

aws cloudformation package \
    --template-file cloudformation.yml \
    --s3-bucket $S3_CLOUDFORMATION_BUCKET \
    --output-template-file ./packaged/cloudformation.yml

aws cloudformation deploy \
    --template-file ./packaged/cloudformation.yml \
    --stack-name $STACK_NAME \
    --capabilities CAPABILITY_IAM \
    --parameter-overrides Password=Password

aws cloudformation deploy \
    --template-file ./packaged/cloudformation.yml \
    --stack-name $STACK_NAME \
    --capabilities CAPABILITY_IAM \
    --parameter-overrides Password=NewPassword

aws cloudformation delete-stack --stack-name $STACK_NAME
aws s3 rb s3://$S3_CLOUDFORMATION_BUCKET --force