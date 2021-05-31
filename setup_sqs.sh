#!/usr/bin/env bash

export ENDPOINT_URL='http://localhost:4566'
export SQS_QUEUE_NAME='FL2-StatementFiles'

ENDPOINT_URL=http://localhost:4566

# brew install jq
SQS_URL=$(aws sqs --endpoint $ENDPOINT_URL get-queue-url --queue-name $SQS_QUEUE_NAME | jq -r '.QueueUrl')
echo "SQS_URL: >> '${SQS_URL}' <<"

if [ -z "${SQS_URL}" ]
then
  echo 'vazio'
else
  # DELETE SQS
  echo 'Deleting SQS'
  aws sqs --endpoint $ENDPOINT_URL delete-queue --queue-url "${SQS_URL}"
fi

# CREATE SQS
echo 'Creating SQS'
aws sqs --endpoint $ENDPOINT_URL create-queue --queue-name $SQS_QUEUE_NAME
