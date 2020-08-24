from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import viewsets, mixins, status
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticatedOrReadOnly

from core.models import Event
from events import serializers
from events.permissions import IsOwnerOrReadOnly
from events.storage import AzureStorage


class EventViewSet(viewsets.ModelViewSet):
    """Manage recipes in the database"""
    serializer_class = serializers.RecipeSerializer
    queryset = Event.objects.all()
    authentication_classes = (TokenAuthentication,)
    permission_classes = [IsAuthenticatedOrReadOnly, IsOwnerOrReadOnly]

    def _params_to_ints(self, qs):
        """Convert a list of string IDs to a list of integers"""
        return [int(str_id) for str_id in qs.split(',')]

    def get_queryset(self):
        """Retrieve the event for the authenticated user"""
        categories = self.request.query_params.get('category')
        owner = self.request.query_params.get('owner')
        queryset = self.queryset
        if categories:
            categories_ids = self._params_to_ints(categories)
            queryset = queryset.filter(category__id__in=categories_ids)
        if owner:
            queryset = queryset.filter(owner=self.request.user)

        return queryset.filter(contributor=self.request.user)

    def perform_create(self, serializer):
        """Create a new recipe"""
        storage = AzureStorage()
        storage_name, connection_str, container_name = storage.create_storage_account(storage)
        serializer.save(
            creator=self.request.user,
            contributor=self.request.user,
            storageAccount=storage_name,
            storageKey=connection_str,
            containerName=container_name,
            isActif=False,
        )

    @action(methods=['POST'], detail=True, url_path='upload-image')
    def upload_image(self, request, pk=None):
        """Upload an image to a recipe"""
        event = self.get_object()
        serializer = self.get_serializer(
            event,
            data=request.data
        )

        if serializer.is_valid():
            serializer.save()
            return Response(
                serializer.data,
                status=status.HTTP_200_OK
            )

        return Response(
            serializer.errors,
            status=status.HTTP_400_BAD_REQUEST
        )
