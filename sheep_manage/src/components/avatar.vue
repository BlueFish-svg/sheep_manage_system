<template>
    <div class="container">
        <el-form>
            <el-upload
                name="avatar"
                :headers="headers"
                class="avatar-uploader"
                :action="getServerUrl()+'user/uploadImage'"
                :show-file-list="false"
                :on-success="handleAvatarSuccess"
                :before-upload="beforeAvatarUpload"
            >
                <img v-if="imageUrl" :src="imageUrl" class="avatar" />
                <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
            </el-upload>
            <el-button @click="handleConfirm" style="margin-left: 17px;
                margin-top: -40px;"  type="primary">确认更换</el-button>
        </el-form>
    </div>

</template>

<script setup>
import {Plus} from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus';
import requestUtil,{getServerUrl} from '@/util/request.js'
import {ref} from 'vue'
const props = defineProps(
    {
      user: {
        type: Object,
        default: () => {
        },
        required: true
      }
    }
)
const headers = ref({
  Authorization: window.sessionStorage.getItem('token')
})

const form = ref({
  id: -1,
  avatar: ''
})


const imageUrl = ref("")

form.value = props.user;
imageUrl.value = getServerUrl() + 'media/userAvatar/' + form.value.avatar
const handleAvatarSuccess = (res) => {
  imageUrl.value = getServerUrl() + 'media/userAvatar/' + res.title
  form.value.avatar = res.title;
}


const beforeAvatarUpload = (file) => {
  const isJPG = file.type === 'image/jpeg'
  const isLt2M = file.size / 1024 / 1024 < 2

  if (!isJPG) {
    ElMessage.error('图片必须是jpg格式')
  }
  if (!isLt2M) {
    ElMessage.error('图片大小不能超过2M!')
  }
  return isJPG && isLt2M
}
const currentUser = JSON.parse(sessionStorage.getItem("currentUser"))
const handleConfirm = async () => {

  let result = await requestUtil.post("user/updateAvatar", form.value);
  let data = result.data;
  if (data.code == 200) {
    currentUser.avatar = form.value.avatar 
    sessionStorage.setItem("currentUser", JSON.stringify(currentUser));
    window.location.reload();// 刷新页面
    ElMessage.success("执行成功！")
  } else {
    ElMessage.error(data.errorInfo);
  }

}


</script>

<style  scoped>
.container {
    width: 120px;
    margin: 5px auto;
}
.avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 120px;
    height: 120px;
    line-height: 120px;
    text-align: center;
    border: 1px dashed #d9d9d9;
    border-radius: 50%;
    cursor: pointer;
    transition: all 0.3s ease;
}
.avatar-uploader-icon:hover {
    border-color: #409eff;
}
.avatar {
    width: 120px;
    height: 120px;
    display: block;
    border-radius: 50%;
    object-fit: cover;
}
</style>