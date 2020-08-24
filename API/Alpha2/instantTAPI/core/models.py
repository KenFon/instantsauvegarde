import uuid

from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, \
                                                    PermissionsMixin
from django.conf import settings


class Achievement(models.Model):
    """User's success"""
    name = models.CharField(max_length=255)
    value = models.IntegerField()


class Challenge(models.Model):
    """Challenges during events"""
    name = models.CharField(max_length=255)


class Photo(models.Model):
    """Retrieve path of Photo"""
    name = models.CharField(max_length=255)
    storage = models.CharField(max_length=255)
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True
    )


class Category(models.Model):
    """Categories of events"""
    name = models.CharField(max_length=255)


class Offer(models.Model):
    """List of offer"""
    name = models.CharField(max_length=255)
    price = models.DecimalField(max_digits=6, decimal_places=2)


class UserManager(BaseUserManager):

    def create_user(self, email, password=None, **extra_fields):
        """Creates and saves a new user"""
        if not email:
            raise ValueError("Vous devez avoir un email valide")
        user = self.model(email=self.normalize_email(email), **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password):
        """Create and saves a new super user"""
        user = self.create_user(email, password)
        user.is_superuser = True
        user.is_staff = True
        user.save(using=self._db)

        return user


class User(AbstractBaseUser, PermissionsMixin):
    """Custom user model"""
    id = models.UUIDField(primary_key=True, default=uuid.uuid4(), editable=False)
    name = models.CharField(max_length=255, default='anonymous')
    email = models.EmailField(max_length=255, unique=True)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    achievements = models.ManyToManyField('Achievement')
    profilePhoto = models.CharField(max_length=255)

    objects = UserManager()

    USERNAME_FIELD = 'email'


class Event(models.Model):
    """Event object"""
    id = models.UUIDField(primary_key=True, default=uuid.uuid4(), editable=False)
    title = models.CharField(max_length=255)
    category = models.ForeignKey(Category, null=True, blank=True, on_delete=models.SET_NULL)
    storage = models.CharField(max_length=255)
    storageKey = models.CharField(max_length=255, blank=True)
    containerName = models.CharField(max_length=255, blank=True)
    startAt = models.DateTimeField()
    endAt = models.DateTimeField()
    creator = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='creator'
    )
    photos = models.ManyToManyField('Photo', blank=True)
    cover = models.CharField(blank=True, max_length=255)
    offer = models.ForeignKey(Offer, null=True, blank=True, on_delete=models.SET_NULL)
    contributor = models.ManyToManyField('User', blank=True, related_name='contributor')
    limitedPhoto = models.IntegerField()
    isActif = models.BooleanField(blank=True, null=True)

    class Meta:
        ordering = ['startAt']
