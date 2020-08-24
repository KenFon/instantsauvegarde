import string
import random


class Utils:
    def name_generator(size=20, chars=string.ascii_lowercase):
        return ''.join(random.choice(chars) for _ in range(size))

    def connection_string(accountName, accountKey):
        connectionKey='DefaultEndpointsProtocol=https;AccountName='+accountName+';AccountKey='+accountKey+';EndpointSuffix=core.windows.net'
        return connectionKey


    # FONCTION DE DEBUG #
    def print_storage(self, group):
        """Print an Azure object instance."""
        print("\tName: {}".format(group.name))
        print("\tId: {}".format(group.id))
        print("\tLocation: {}".format(group.location))
        print("\tTags: {}".format(group.tags))
        if hasattr(group, 'properties'):
            self.print_properties(group.properties)

    def print_properties(props):
        """Print a ResourceGroup properties instance."""
        if props and props.provisioning_state:
            print("\tProperties:")
            print("\t\tProvisioning State: {}".format(props.provisioning_state))
        print("\n\n")

