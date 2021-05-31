from os import environ, remove

import boto3

# environ['ACCESS_KEY'] = '1234567890'
# environ['SECRET_KEY'] = '1234567890'
# environ['ENDPOINT_URL'] = 'http://localhost:4566'
# environ['REGION'] = 'us-east-1'
# environ['BUCKET_GLOBAL'] = 'fl2-statement-global'
# environ['BUCKET_GLOBAL_BACKUP'] = 'fl2-statement-global-bkp'
# environ['BUCKET_TRANSFER'] = 'fl2-statement-transfer'
# environ['BUCKET_PENDING_PROCESS'] = 'fl2-statement-pending-process'


ACCESS_KEY = environ['ACCESS_KEY']
SECRET_KEY = environ['SECRET_KEY']
ENDPOINT_URL = environ['ENDPOINT_URL']
REGION = environ['REGION']
BUCKET_GLOBAL = environ['BUCKET_GLOBAL']
BUCKET_GLOBAL_BACKUP = environ['BUCKET_GLOBAL_BACKUP']
BUCKET_TRANSFER = environ['BUCKET_TRANSFER']
BUCKET_PENDING_PROCESS = environ['BUCKET_PENDING_PROCESS']


def __get_client():
    return boto3.client(
                    's3',
                    region_name=REGION,
                    endpoint_url=ENDPOINT_URL,
                    aws_access_key_id=ACCESS_KEY,
                    aws_secret_access_key=SECRET_KEY)


def get_object(bucket_name, key):
    client = __get_client()
    return client.get_object(Bucket=bucket_name,
                             Key=key)


def move_object(bucket_origin, key_origin, bucket_destination, key_destination):
    client = __get_client()
    client.copy_object(Bucket=bucket_destination,
                       Key=key_destination,
                       CopySource={
                           'Bucket': bucket_origin,
                           'Key': key_origin
                       })
    delete_object(bucket_name=bucket_origin, key=key_origin)


def delete_object(bucket_name, key):
    client = __get_client()
    return client.delete_object(Bucket=bucket_name,
                                Key=key)


def put_object(bucket_name, key, file):
    client = __get_client()
    return client.put_object(Bucket=bucket_name,
                             Key=key,
                             Body=file)


def list_all_buckets():
    client = __get_client()
    response = client.list_buckets()
    # print(response)
    return response['Buckets']


if __name__ == '__main__':

    pass

    # file = open('EEVC.TXT', mode='rb')
    # put_object(BUCKET_GLOBAL, 'EEVC.TXT', file)  # OK
    #
    # file = get_object(BUCKET_GLOBAL, 'EEVC.TXT')
    # if file is not None:
    #     file = file['Body']
    #     file = file.read().decode('ascii')
    # else:
    #     exit(1)
    #
    # lines = file.split('\n')
    # file_type = None
    # current_establishment = None
    # building_file = None
    #
    # for line in lines:
    #     if line[19:20] == '@':  # entao eh cabecalho com tipo de arquivo
    #         file_type = line[48:52]
    #         continue
    #
    #     if file_type not in ['EEVC', 'NNVC', 'NEVC', 'EEVD', 'NNVD', 'NEVD', 'EEFI',
    #                          'NNFI', 'NEFI', 'EESA', 'NNSA', 'NESA']:
    #         raise Exception('File type not treated in this process')
    #
    #     if file_type is not None:
    #
    #         # if register_type in ['EEVC', 'NNVC', 'NEVC']:
    #
    #         register_type = line[19:22]
    #         if register_type == '002':  # entao eh cabecalho da matriz
    #             current_establishment = line[75:82]
    #             file_name = f'{current_establishment}.TXT'
    #             building_file = open(file_name, mode='wb')
    #             building_file.write(f'{line[19:]}\n'.encode())
    #             continue
    #         elif not register_type == '028':  # se for registros do bloco, continuar gravando no arquivo
    #             building_file.write(f'{line[19:]}\n'.encode())
    #             continue
    #         elif register_type == '028':  # eh fim de bloco, salvar arquivo, enviar para bucket e ir para proxima linha
    #             building_file.write(f'{line[19:]}\n'.encode())
    #             building_file.close()
    #             send_file = open(file_name, 'rb')
    #             put_object(BUCKET_PENDING_PROCESS, file_name, send_file)  # OK
    #             send_file.close()
    #             remove(file_name)
    #             file_type = None
    #             current_establishment = None
    #             building_file = None
    #             continue
    #
    # delete_object(BUCKET_GLOBAL, 'EEVC.TXT')

    # put_object(BUCKET_GLOBAL, 'EEVC.TXT', file)  # OK
    # list_all_buckets()  # OK
