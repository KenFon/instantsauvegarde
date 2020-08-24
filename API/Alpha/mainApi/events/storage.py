from azure.common.credentials import ServicePrincipalCredentials
from azure.mgmt.resource import ResourceManagementClient
from azure.mgmt.storage import StorageManagementClient
from azure.mgmt.storage.models import StorageAccountCreateParameters
from azure.mgmt.storage.models import (
    StorageAccountCreateParameters,
    StorageAccountUpdateParameters,
    Sku,
    SkuName,
    Kind
)
from azure.storage.blob import BlobServiceClient, BlobClient, ContainerClient, PublicAccess
import uuid
from mainApi.Utils.Utils import Utils


class AzureStorage:
    subscription_id = "f1a64d2c-a48b-4fed-af04-7f78364b176c"
    credentials = ServicePrincipalCredentials(
        client_id="b86110f5-34f9-470f-b3a5-d1f4f7a687c0",
        secret="J-8GBQgtdY.z]?8S97dwGCeTxPJuM1kB",
        tenant="3715d4db-cb52-4937-af91-4c750e1b2815"
    )

    resource_client = ResourceManagementClient(credentials, subscription_id)
    storage_client = StorageManagementClient(credentials, subscription_id)

    @staticmethod
    def create_storage_account(self):
        self.resource_client.providers.register('Microsoft.Storage')
        storage_name = Utils.name_generator()

        # Check availability
        availability = self.storage_client.storage_accounts.check_name_availability(storage_name)

        while not availability:
            storage_name = Utils.name_generator()
            availability = self.storage_client.storage_accounts.check_name_availability(storage_name)

        if availability:
            storage_async_operation = self.storage_client.storage_accounts.create(
                'InstanT',
                storage_name,
                StorageAccountCreateParameters(
                    sku=Sku(name=SkuName.standard_ragrs),
                    kind=Kind.storage,
                    location='francecentral',
                    enable_https_traffic_only=True
                )
            )
            storage_account = storage_async_operation.result()
            Utils.print_storage(self, storage_account)
            storage_keys = self.storage_client.storage_accounts.list_keys('InstanT', storage_name)
            storage_keys = {v.key_name: v.value for v in storage_keys.keys}
            connection_str = Utils.connection_string(storage_name, storage_keys['key1'])
            # faire un return ici, le reste est du test
            blob_service_client = BlobServiceClient.from_connection_string(connection_str)
            container_name = "test" + str(uuid.uuid4())
            container_client = blob_service_client.create_container(container_name, public_access=PublicAccess.Container)
            return storage_name, connection_str, container_name
            # local_path = "../testimg/test.jpg"
            # blob_client = blob_service_client.get_blob_client(container=container_name, blob=str(uuid.uuid4())+'.jpg')
            # with open(local_path, "rb") as data:
                # blob_client.upload_blob(data)

