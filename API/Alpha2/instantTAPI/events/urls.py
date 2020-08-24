from django.urls import path, include
from rest_framework.routers import DefaultRouter

from events import views


router = DefaultRouter()
router.register('events', views.EventSerializer)

app_name = 'events'

urlpatterns = [
    path('', include(router.urls))
]
