import json
import uuid
from datetime import datetime
from django.core.paginator import Paginator
from django.db.models import Count
from django.http import JsonResponse, Http404
from django.views import View
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.viewsets import ModelViewSet
from rest_framework_jwt.settings import api_settings

from sheep_manage_system import settings
from user.models import SysUser, SheepCategory, Sheep
from user.serializer_user import SysUserSerializer, SheepCategorySerializer, SheepSerializer
from rest_framework.response import Response

class LoginView(View):
    def post(self, request):
        username=request.GET.get('username')
        password=request.GET.get('password')
        try:
            user=SysUser.objects.get(username=username,password=password)
            jwt_payload_handler = api_settings.JWT_PAYLOAD_HANDLER
            jwt_encode_handler = api_settings.JWT_ENCODE_HANDLER
            # 将用户对象传递进去，获取到该对象的属性值
            payload = jwt_payload_handler(user)
            # 将属性值编码成jwt格式的字符串
            token = jwt_encode_handler(payload)
        except Exception as e:
            return JsonResponse({'code':500,'info':'用户名或者密码错误!'})
        return JsonResponse({'code':200,'token':token,'user':SysUserSerializer(user).data,'info':'登录成功'})
class SearchView(View):
    def post(self, request):
        data = json.loads(request.body.decode("utf-8"))
        pageNum = data['pageNum']  # 当前页
        pageSize = data['pageSize']  # 每页大小
        query = data['query']  # 查询参数
        # 过滤数据
        filtered_sheep = SheepCategory.objects.filter(sheep_category_name__icontains=query)
        # 计算总记录数
        total = filtered_sheep.count()
        # 计算总页数
        total_pages = (total + pageSize - 1) // pageSize
        # 检查页码是否超出有效范围
        if pageNum > total_pages:
            pageNum = total_pages if total_pages > 0 else 1
        # 进行分页
        sheepListPage = Paginator(filtered_sheep, pageSize).page(pageNum)
        obj_sheeps = sheepListPage.object_list.values()  # 转成字典
        sheeps = list(obj_sheeps)  # 把外层的容器转为List
        return JsonResponse({'code': 200, 'sheepList': sheeps, 'total': total})
class SheepListView(APIView):
    # 添加羊的种类功能
    def post(self, request,format=None):
        # 创建序列化器
        ser = SheepCategorySerializer(data=request.data)
        # 校验请求参数
        if ser.is_valid():
            ser.save()  # 保存数据到数据库
            data = {'code': 201, "data": ser.data, "message": "添加成功！"}
            return Response(data, status=status.HTTP_201_CREATED)
        else:
            data = {'code': 400, "message": ser.errors}
            return Response(data, status=status.HTTP_400_BAD_REQUEST)

class SheepDetailView(APIView):
    def get_object(self, id):
        try:
            return SheepCategory.objects.get(id=id)
        except Exception as e:
            raise Http404()

    def get(self, request, id, format=None):
        # 获取单个资源
        obj = self.get_object(id)
        ser = SheepCategorySerializer(obj)
        data = {'code': 200, 'data': ser.data, 'message': 'OK'}
        return Response(data, status=status.HTTP_200_OK)

    def delete(self, request, id, format=None):
            obj = self.get_object(id)
            obj.delete()
            # 使用 204 状态码，不返回响应体
            return Response(status=status.HTTP_204_NO_CONTENT)
    # 编辑羊的种类功能
    def put(self, request, id, format=None):
        obj = self.get_object(id)
        # 修改资源
        ser = SheepCategorySerializer(instance=obj, data=request.data)
        if ser.is_valid():
            ser.save()
            return Response({'code': 200, 'data': ser.data, 'message': '编辑成功!'}, status=status.HTTP_200_OK)
        else:
            return Response({'code': 400, "message": ser.errors}, status=status.HTTP_400_BAD_REQUEST)
# 修改密码
class PwdView(View):
    def post(self, request):
        data = json.loads(request.body.decode("utf-8"))
        id = data['id']
        oldPassword = data['oldPassword']
        newPassword = data['newPassword']
        newUsername = data.get('username')  # 获取新用户名
        try:
            obj_user = SysUser.objects.get(id=id)
            if obj_user.password == oldPassword:
                # 修改用户名
                if newUsername:
                    obj_user.username = newUsername
                # 修改密码
                if newPassword:
                    obj_user.password = newPassword
                obj_user.save()
                return JsonResponse({'code': 200})
            else:
                return JsonResponse({'code': 500, 'errorInfo': '原密码错误！'})
        except SysUser.DoesNotExist:
            return JsonResponse({'code': 500, 'errorInfo': '用户不存在！'})


class ImageView(View):

    def post(self, request):
        file = request.FILES.get('avatar')
        print("file:", file)
        if file:
            file_name = file.name
            suffixName = file_name[file_name.rfind("."):]
            new_file_name = datetime.now().strftime('%Y%m%d%H%M%S') + suffixName
            file_path = str(settings.MEDIA_ROOT) + "\\userAvatar\\" + new_file_name
            print("file_path:", file_path)
            try:
                with open(file_path, 'wb') as f:
                    for chunk in file.chunks():
                        f.write(chunk)
                return JsonResponse({'code': 200, 'title': new_file_name})
            except:
                return JsonResponse({'code': 500, 'errorInfo': '上传头像失败'})


class AvatarView(View):

    def post(self, request):
        data = json.loads(request.body.decode("utf-8"))
        id = data['id']
        avatar = data['avatar']
        obj_user = SysUser.objects.get(id=id)
        obj_user.avatar = avatar
        obj_user.save()
        return JsonResponse({'code': 200})

# 羊只的查询
class SearchSheepView(View):
    def post(self, request):
        # 解析请求体中的 JSON 数据
        data = json.loads(request.body.decode("utf-8"))
        # 获取当前页码
        page_num = int(data.get('pageNum', 1))
        # 获取每页显示的记录数
        page_size = int(data.get('pageSize', 10))
        # 获取查询参数
        query = data.get('query', '')
        # 过滤数据，支持多字段查询
        filtered_sheep = Sheep.objects.select_related('sheep_type').filter(
            sheep_id__icontains=query
        )
        # 计算总记录数
        total = filtered_sheep.count()
        # 计算总页数
        total_pages = (total + page_size - 1) // page_size
        # 检查页码是否超出有效范围
        if page_num > total_pages:
            page_num = total_pages if total_pages > 0 else 1
        # 进行分页
        sheep_list_page = Paginator(filtered_sheep, page_size).page(page_num)
        # 转成字典，并处理外键字段
        sheep_list = []
        for sheep in sheep_list_page.object_list:
            sheep_data = {
                'id': sheep.id,
                'sheep_id': sheep.sheep_id,
                'sheep_type': sheep.sheep_type.sheep_category_name,
                'sheep_sex': sheep.get_sheep_sex_display(),
                'sheep_age': sheep.sheep_age,
                'health_condition': sheep.get_health_condition_display()
            }
            sheep_list.append(sheep_data)
        sheep_type=SheepCategory.objects.all()
        sheep_type=list(sheep_type.values())
        return JsonResponse({'code': 200, 'sheepList': sheep_list, 'total': total,'sheepType': sheep_type})

#羊只的添加和编辑
import json
import uuid
from django.http import JsonResponse
from django.views import View
from django.utils import timezone
# 假设Sheep是你的模型
# from .models import Sheep

class addAndEditSheep(View):
    def post(self, request):
        data = json.loads(request.body.decode("utf-8"))
        if data['id'] == -1:
            try:
                obj_sheep = Sheep(sheep_type_id=data['sheep_type'], sheep_sex=data['sheep_sex'], sheep_age=data['sheep_age'], health_condition=data['health_condition'])
                # 生成 UUID
                unique_id = str(uuid.uuid4()).replace('-', '')
                obj_sheep.sheep_id = unique_id
                obj_sheep.save()
                return JsonResponse({'code': 200})
            except Exception as e:
                return JsonResponse({'code': 500, 'errorInfo': "添加失败！"})
        else:  # 修改
            try:
                # 获取要修改的对象
                obj_sheep = Sheep.objects.get(id=data['id'])
                obj_sheep.sheep_type_id = data['sheep_type']
                obj_sheep.sheep_sex = data['sheep_sex']
                obj_sheep.sheep_age = data['sheep_age']
                obj_sheep.health_condition = data['health_condition']
                # 不修改 sheep_id
                obj_sheep.save()
                return JsonResponse({'code': 200})
            except Exception as e:
                return JsonResponse({'code': 500, 'errorInfo': "修改失败！"})

# 根据id查询羊只
class idSearchSheepView(View):
    def get(self,request):
        try:
            id=request.GET.get('id')
            only_sheep=Sheep.objects.get(id=id)
            ser = SheepSerializer(only_sheep)
            return JsonResponse({'code': 200, 'only_sheep':ser.data })
        except Exception as e:
            return JsonResponse({'code': 500, 'errorInfo': "查询失败！"})
#删除和批量的删除
class deleteSheepView(View):
    def delete(self,request):
        try:
            idList=json.loads(request.body.decode("utf-8"))
            deleted_count, _ =Sheep.objects.filter(id__in=idList).delete()
            print(deleted_count)
            if not deleted_count:
                return JsonResponse({'code': 500, 'errorInfo': "删除失败！"})
            return JsonResponse({'code': 200})
        except Exception as e:
            return JsonResponse({'code': 500, 'errorInfo': "删除失败！"})
# 饼图数据获取
class Search_data(APIView):
    def get(self,request):
            # 获取所有羊的数据
            sheep = Sheep.objects.all()
            # 获取数据的总数量
            total_count = sheep.count()
            # 获取公羊和母羊的数量
            male_sheep_count = sheep.filter(sheep_sex=1).count()  # 公羊数量
            female_sheep_count = sheep.filter(sheep_sex=2).count()  # 母羊数量
            # 返回响应，包含数据和总数量
            return Response({
                'code': 200,
                'total_count': total_count,  # 总数量
                'male_sheep_count': male_sheep_count,  # 公羊数量
                'female_sheep_count': female_sheep_count,  # 母羊数量
            })
#柱状图数据获取
class Bar_SearchData(APIView):
    def get(self, request):
        # 获取每个羊种类及其对应的数量
        sheep_data = Sheep.objects.values('sheep_type__sheep_category_name').annotate(count=Count('id'))

        # 将数据格式化为前端需要的格式
        categories = [item['sheep_type__sheep_category_name'] for item in sheep_data]  # 种类名称
        counts = [item['count'] for item in sheep_data]  # 每种羊的数量

        # 返回响应
        return Response({
            'code': 200,
            'categories': categories,  # 羊种类名称列表
            'counts': counts,  # 每种羊的数量列表
        })


