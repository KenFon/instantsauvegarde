from events.models import Event
from events.serializers import EventSerializer
from rest_framework import generics
from events.permissions import IsOwnerOrReadOnly
from rest_framework import permissions
from events.storage import AzureStorage
# Create your views here.


class EventList(generics.ListCreateAPIView):
    queryset = Event.objects.all()
    serializer_class = EventSerializer

    def perform_create(self, serializer):
        storage = AzureStorage()
        storage_name, connection_str, container_name = storage.create_storage_account(storage)
        serializer.save(
            owner=self.request.user,
            storageAccount=storage_name,
            storageKey=connection_str,
            containerName=container_name
        )


class EventDetail(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = [permissions.IsAuthenticatedOrReadOnly,
                          IsOwnerOrReadOnly]
    queryset = Event.objects.all()
    serializer_class = EventSerializer






