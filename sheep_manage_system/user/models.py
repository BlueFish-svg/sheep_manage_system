from django.db import models


class SysUser(models.Model):
    id = models.AutoField(primary_key=True)
    username = models.CharField(max_length=100, unique=True, verbose_name="用户名")
    password = models.CharField(max_length=100, verbose_name="密码")
    avatar = models.CharField(max_length=255, null=True, verbose_name="用户头像")
    class Meta:
        db_table = "sys_user"
class SheepCategory(models.Model):
    id = models.AutoField(primary_key=True)
    sheep_category_name=models.CharField(max_length=100,verbose_name="种类名称")
    sheep_category_address=models.CharField(max_length=800,verbose_name="地址区域")
    create_time = models.DateField(max_length=100, verbose_name="添加时间")
    class Meta:
        db_table = "sheep_category"
    def __str__(self):
        return self.sheep_category_name
class Sheep(models.Model):
    id = models.AutoField(primary_key=True)
    sheep_id=models.CharField(max_length=255,verbose_name="羊只编号")
    sheep_type = models.ForeignKey(verbose_name="羊只种类", to="SheepCategory",to_field="id", on_delete=models.CASCADE)
    sex_choices=((1,"公羊"),(2,"母羊"))
    sheep_sex=models.SmallIntegerField(choices=sex_choices,verbose_name="羊只性别")
    sheep_age=models.IntegerField(verbose_name="羊龄", default=0)
    health_choices=((1,"健康"),(2,"良好"),(3,"患病"),(4,"其他"),)
    health_condition=models.SmallIntegerField(verbose_name="健康状况", choices=health_choices)
    class Meta:
        db_table = "sheep"
