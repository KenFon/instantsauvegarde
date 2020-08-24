from django.db import models
from django.contrib.auth.models import User
from photos.models import Photo
import uuid
# Create your models here.


class Event(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    title = models.CharField(max_length=100, blank=False)
    createdAt = models.DateTimeField(auto_now_add=True)
    type = models.CharField(default='', blank='False', max_length=100)
    startAt = models.DateTimeField()
    endAt = models.DateTimeField()
    owner = models.ForeignKey('auth.User', related_name='events', on_delete=models.CASCADE)
    photos = models.ManyToManyField(Photo, blank=True)
    followers = models.ManyToManyField(User, blank=True)
    storageAccount = models.CharField(blank=True, max_length=24)
    storageKey = models.CharField(blank=True, max_length=100)
    containerName = models.CharField(blank=True, max_length=100)
    cover = models.CharField(blank=True, max_length=100)
    offer = models.CharField(blank=False, max_length=50, default='Free')

    class Meta:
        ordering = ['startAt']


