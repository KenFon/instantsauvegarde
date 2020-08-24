from django.db import models
import uuid

# Create your models here.


class Photo(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    path = models.CharField(max_length=100)
    isMain = models.BooleanField(default=False)

