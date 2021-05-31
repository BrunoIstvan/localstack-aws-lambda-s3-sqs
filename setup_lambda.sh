#!/usr/bin/env bash

DEFAULT_REGION='us-east-1'
LAMBDA_STATEMENT_SPLIT_BLOCK=lambda-statement-split-block
LAMBDA_PROCESSING_STATEMENT=lambda-processing-statement

export ACCESS_KEY='1234567890'
export SECRET_KEY='1234567890'
export ENDPOINT_URL='http://localhost:4566'
export REGION=$DEFAULT_REGION
export BUCKET_GLOBAL='fl2-statement-global'
export BUCKET_GLOBAL_BACKUP='fl2-statement-global-bkp'
export BUCKET_TRANSFER='fl2-statement-transfer'
export BUCKET_PENDING_PROCESS='fl2-statement-pending-process'

ENDPOINT_URL=http://localhost:4566

echo $ENDPOINT_URL

#function does_lambda_exist() {
#  aws lambda get-function --function-name $1 > /dev/null 2>&1
#  if [ 0 -eq $? ]; then
#
#    echo "Lambda '$1' exists"
#    # DELETE LAMBDA
#    echo "Deleting Lambda '$1'"
aws lambda --endpoint $ENDPOINT_URL delete-function --function-name $LAMBDA_STATEMENT_SPLIT_BLOCK
#aws lambda --endpoint $ENDPOINT_URL delete-function --function-name $LAMBDA_PROCESSING_STATEMENT

#  else
#    echo "Lambda '$1' does not exist"
#  fi
#}
#does_lambda_exist ${LAMBDA_STATEMENT_SPLIT_BLOCK}
#
#does_lambda_exist ${LAMBDA_PROCESSING_STATEMENT}

aws iam --endpoint $ENDPOINT_URL delete-role --role-name lambda-role

LAMBDA_ROLE=$(aws iam --endpoint $ENDPOINT_URL create-role --role-name lambda-role \
                      --assume-role-policy-document file://role.json | jq -r ".Role.Arn" )

echo "$LAMBDA_ROLE"

PWD=$(pwd)
FILE="${PWD}/lambda.zip"
if test -f "$FILE"; then
  echo 'Deleting zip file'
  rm lambda.zip
fi
echo 'Ziping file'
zip -r lambda.zip "${PWD}"/*.py


# CREATE LAMBDA
echo "Creating Lambda '${LAMBDA_STATEMENT_SPLIT_BLOCK}'"
LAMBDA_ARN=$(aws lambda --endpoint $ENDPOINT_URL create-function \
                       --function-name $LAMBDA_STATEMENT_SPLIT_BLOCK \
                       --role lambda-role \
                       --runtime python3.7 \
                       --zip-file fileb://lambda.zip \
                       --environment "Variables={ACCESS_KEY=${ACCESS_KEY},
                                                 SECRET_KEY=${SECRET_KEY},
                                                 ENDPOINT_URL=${ENDPOINT_URL},
                                                 REGION=${REGION},
                                                 BUCKET_GLOBAL=${BUCKET_GLOBAL},
                                                 BUCKET_GLOBAL_BACKUP=${BUCKET_GLOBAL_BACKUP},
                                                 BUCKET_TRANSFER=${BUCKET_TRANSFER},
                                                 BUCKET_PENDING_PROCESS=${BUCKET_PENDING_PROCESS}}" \
                       | jq -r ".FunctionArn")

echo $LAMBDA_ARN

aws s3api --endpoint $ENDPOINT_URL put-bucket-notification-configuration \
          --bucket ${BUCKET_GLOBAL} \
          --notification-configuration file://s3-lambda-notification.json

