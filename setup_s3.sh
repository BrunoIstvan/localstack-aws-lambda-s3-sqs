#!/usr/bin/env bash

export ENDPOINT_URL='http://localhost:4566'
export BUCKET_GLOBAL='fl2-statement-global'
export BUCKET_GLOBAL_BACKUP='fl2-statement-global-bkp'
export BUCKET_TRANSFER='fl2-statement-transfer'
export BUCKET_PENDING_PROCESS='fl2-statement-pending-process'

ENDPOINT_URL=http://localhost:4566

# DELETE BUCKET
# Delete bucket global
echo 'Delete bucket global'
aws s3 --endpoint $ENDPOINT_URL rb s3://$BUCKET_GLOBAL --force

# Delete bucket backup of global
echo 'Delete bucket backup of global'
aws s3 --endpoint $ENDPOINT_URL rb s3://$BUCKET_GLOBAL_BACKUP --force

# Delete bucket that will store data from blocks
echo 'Delete bucket that will store data from blocks'
aws s3 --endpoint $ENDPOINT_URL rb s3://$BUCKET_PENDING_PROCESS --force

# Delete bucket with files that will be transfered to the conciliator
echo 'Delete bucket with files that will be transfered to the conciliator'
aws s3 --endpoint $ENDPOINT_URL rb s3://$BUCKET_TRANSFER --force

# CREATE BUCKET
# Create bucket global
echo 'Create bucket global'
aws s3 --endpoint $ENDPOINT_URL mb s3://$BUCKET_GLOBAL

# Create bucket backup of global
echo 'Create bucket backup of global'
aws s3 --endpoint $ENDPOINT_URL mb s3://$BUCKET_GLOBAL_BACKUP

# Create bucket that will store data from blocks
aws s3 --endpoint $ENDPOINT_URL mb s3://$BUCKET_PENDING_PROCESS

# Create bucket with files that will be transfered to the conciliator
aws s3 --endpoint $ENDPOINT_URL mb s3://$BUCKET_TRANSFER

