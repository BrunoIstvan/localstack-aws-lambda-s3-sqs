#!/usr/bin/env bash

sh ./setup_s3.sh

sh ./setup_sqs.sh

DEFAULT_REGION='us-east-1'
LAMBDA_STATEMENT_SPLIT_BLOCK='lambda-statement-split-block'
LAMBDA_PROCESSING_STATEMENT='lambda-processing-statement'

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

  echo "CHECK IF LAMBDA EXISTS "
  LAMBDA_EXISTS=$(aws lambda --endpoint $ENDPOINT_URL function-exists --function-name ${LAMBDA_STATEMENT_SPLIT_BLOCK})
  echo "LAMBDA EXISTS >> '${LAMBDA_EXISTS}' << "

  if [ -z "${LAMBDA_EXISTS}" ]
  then
    echo "Lambda ${LAMBDA_STATEMENT_SPLIT_BLOCK} nao existente"
  else
    # DELETE LAMBDA
    echo 'Deleting Lambda'
    aws lambda --endpoint $ENDPOINT_URL delete-function --function-name ${LAMBDA_STATEMENT_SPLIT_BLOCK}
  fi
#
#  PWD=$(pwd)
#  FILE='lambda.zip'
#  if test -f "$FILE"; then
#    rm lambda.zip
#  fi
#  zip -r lambda.zip "${PWD}"/*.py
#
#
#  # CREATE LAMBDA
#  echo 'Creating Lambda'
#  aws lambda --endpoint $ENDPOINT_URL create-function \
#             --region ${DEFAULT_REGION} \
#             --function-name ${LAMBDA_STATEMENT_SPLIT_BLOCK} \
#             --runtime python3.7 \
#             --role irrelevant \
#             --handler main.execute \
#             --zip-file fileb://lambda.zip

#fi

#
#python3 s3Service.py