from django.contrib import admin
from django.urls import path, include, re_path
from django.views.static import serve

from sheep_manage_system import settings

urlpatterns = [
    # path('admin/', admin.site.urls),
    path('user/',include('user.urls')),#用户模块
    # 配置媒体文件的路由地址
    re_path('media/(?P<path>.*)', serve, {'document_root': settings.MEDIA_ROOT}, name='media')
]
