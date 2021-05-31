from os import environ
from process import process
from s3Service import put_object

environ['ACCESS_KEY'] = '1234567890'
environ['SECRET_KEY'] = '1234567890'
environ['ENDPOINT_URL'] = 'http://localhost:4566'
environ['REGION'] = 'us-east-1'
environ['BUCKET_GLOBAL'] = 'fl2-statement-global'
environ['BUCKET_GLOBAL_BACKUP'] = 'fl2-statement-global-bkp'
environ['BUCKET_TRANSFER'] = 'fl2-statement-transfer'
environ['BUCKET_PENDING_PROCESS'] = 'fl2-statement-pending-process'

BUCKET_GLOBAL = environ['BUCKET_GLOBAL']


# def test():
#
#     file = open('EEVC.TXT', mode='rb')
#     put_object(BUCKET_GLOBAL, 'EEVC.TXT', file)  # OK
#
#     file = open('EEVD.TXT', mode='rb')
#     put_object(BUCKET_GLOBAL, 'EEVD.TXT', file)  # OK
#
#     file = open('EEFI.TXT', mode='rb')
#     put_object(BUCKET_GLOBAL, 'EEFI.TXT', file)  # OK
#
#     file = open('EESA.TXT', mode='rb')
#     put_object(BUCKET_GLOBAL, 'EESA.TXT', file)  # OK


def execute(event, context):

    print(event)
    pass

    # payload = {'Bucket': BUCKET_GLOBAL, 'Key': 'EEVC.TXT'}
    # process(bucket=payload['Bucket'], key=payload['Key'])
    #
    # payload = {'Bucket': BUCKET_GLOBAL, 'Key': 'EEVD.TXT'}
    # process(bucket=payload['Bucket'], key=payload['Key'])
    #
    # payload = {'Bucket': BUCKET_GLOBAL, 'Key': 'EEFI.TXT'}
    # process(bucket=payload['Bucket'], key=payload['Key'])
    #
    # payload = {'Bucket': BUCKET_GLOBAL, 'Key': 'EESA.TXT'}
    # process(bucket=payload['Bucket'], key=payload['Key'])


# Press the green button in the gutter to run the script.
# if __name__ == '__main__':
#     test()
#     execute(None, None)
