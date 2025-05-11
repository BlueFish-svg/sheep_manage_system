from rest_framework import serializers

from user.models import SysUser, SheepCategory, Sheep


class SysUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = SysUser
        fields = '__all__'
class SheepCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = SheepCategory
        fields = '__all__'
class SheepSerializer(serializers.ModelSerializer):
    class Meta:
        model = Sheep
        fields = '__all__'