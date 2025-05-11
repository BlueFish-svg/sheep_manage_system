from django.urls import path

from user import views
from user.views import LoginView, SearchView, PwdView, ImageView, AvatarView, SearchSheepView, \
    idSearchSheepView, addAndEditSheep, deleteSheepView, Search_data, Bar_SearchData

urlpatterns = [
    path('login', LoginView.as_view(), name='login'),#登录
    path('search', SearchView.as_view(), name='search'),  # 羊只种类信息查询
    path('sheep',views.SheepListView.as_view()),#添加功能
    path('sheep/<int:id>', views.SheepDetailView.as_view()),  # 编辑功能
    path('updateUserPwd', PwdView.as_view(), name='updateUserPwd'),  # 修改密码

    path('uploadImage', ImageView.as_view(), name='uploadImage'),  # 头像上传
    path('updateAvatar', AvatarView.as_view(), name='updateAvatar'),  # 更新头像
    path('searchList', SearchSheepView.as_view(), name='searchList'),  # 羊只信息的查询
    path('addAndEditSheep', addAndEditSheep.as_view(), name='addAndEditSheep'),  # 羊只信息的添加和编辑
    path('id_search_sheep', idSearchSheepView.as_view(), name='id_search_sheep'),  # 通过id查询羊只信息
    path('delete_sheep',deleteSheepView.as_view(), name='delete_sheep'), #删除和批量删除
    path('search_data', Search_data.as_view(), name='search_data'),  # 饼图数据获取
    path('bar_searchData', Bar_SearchData.as_view(), name='bar_searchData'),  # 柱状图数据获取
]
