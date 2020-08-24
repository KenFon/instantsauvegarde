from django.contrib.auth.models import User
from rest_framework import serializers
from events.models import Event
from events.storage import AzureStorage


class EventSerializer(serializers.ModelSerializer):
    owner = serializers.ReadOnlyField(source='owner.username')

    class Meta:
        model = Event
        fields = [
                    'id',
                    'title',
                    'createdAt',
                    'type',
                    'startAt',
                    'endAt',
                    'owner',
                    'photos',
                    'followers',
                    'storageAccount',
                    'storageKey',
                    'containerName',
                    'cover',
                    'offer'
                  ]


class UserSerializer(serializers.ModelSerializer):
    events = serializers.PrimaryKeyRelatedField(many=True, queryset=Event.objects.all())

    class Meta:
        model = User
        fields = ['id', 'username', 'events']

