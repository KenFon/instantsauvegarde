from rest_framework import serializers

from core.models import Category, Challenge, Photo, User, Event, Offer


class PhotoSerializer(serializers.ModelSerializer):

    class Meta:
        model = Photo
        fields = ('id', 'name')
        read_only_fields = ('id',)


class ChallengeSerializer(serializers.ModelSerializer):
    """Serializer for tag objects"""

    class Meta:
        model = Challenge
        fields = ('id', 'name')
        read_only_fields = ('id',)


class CategorySerializer(serializers.ModelSerializer):
    """Serializer for ingredient objects"""

    class Meta:
        model = Category
        fields = ('id', 'name')
        read_only_fields = ('id',)


class OfferSerializer(serializers.ModelSerializer):
    """Serializer for ingredient objects"""

    class Meta:
        model = Offer
        fields = ('id', 'name')
        read_only_fields = ('id',)


class EventSerializer(serializers.ModelSerializer):
    """Serializer a recipe"""
    contributor = serializers.PrimaryKeyRelatedField(
        many=True,
        queryset=User.objects.all()
    )
    photos = serializers.PrimaryKeyRelatedField(
        many=True,
        queryset=Photo.objects.all()
    )

    class Meta:
        model = Event
        fields = ('id', 'title', 'category', 'storage', 'storageKey',
                  'containerName', 'startAt', 'endAt', 'creator', 'photos', 'cover',
                  'offer', 'contributor', 'limitedPhoto', 'isActif'
                  )
        read_only_fields = ('id',)


class EventImageSerializer(serializers.ModelSerializer):
    """Serializer for uploading images to recipes"""

    class Meta:
        model = Event
        fields = ('id', 'photo')
        read_only_fields = ('id',)
