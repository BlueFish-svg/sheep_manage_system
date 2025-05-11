<template>
<el-dropdown>
    <span class="el-dropdown-link">
        <el-avatar shape="square" :size="50" :src="squareUrl" style="border-radius: 25px 25px 25px 25px;"/>
        <b style="padding-left: 10px;color: #fff;">{{ currentUser.username }}</b>
      <el-icon class="el-icon--right">
        <arrow-down />
      </el-icon>
    </span>
    <template #dropdown>
      <el-dropdown-menu>
        <el-dropdown-item @click="personShow=true">个人中心</el-dropdown-item>
        <el-dropdown-item @click="logout">安全退出</el-dropdown-item>
      </el-dropdown-menu>
    </template>
  </el-dropdown>
  <!-- 个人中心的对话框 -->
  <el-dialog v-model="personShow" title="个人中心" width="30%" draggable @close="clickCancel">
    <avatar :user="currentUser"></avatar>
    <el-form :model="userInfomation" ref="pwdRef"  :rules="rules" style="text-align: center;">
      <el-form-item label="用户名" prop="username">
        <el-input  autocomplete="off" placeholder="请输入用户名"  prefix-icon="User" v-model="userInfomation.username"/>
      </el-form-item>
      <el-form-item label="原密码" prop="oldPassword">
        <el-input type="password"  placeholder="请输入旧密码" prefix-icon="Lock" v-model="userInfomation.oldPassword" autocomplete="off" show-password/>
      </el-form-item>
      <el-form-item label="新密码"  prop="newPassword" style="padding-left: 10px;">
        <el-input type="password" autocomplete="off" placeholder="请输入新密码" prefix-icon="Lock"   v-model="userInfomation.newPassword" show-password/>
      </el-form-item>
      <el-form-item label="确认密码" prop="confirmPassword">
        <el-input type="password" autocomplete="off" placeholder="请输入确认密码" prefix-icon="Lock" v-model="userInfomation.confirmPassword" show-password/>
      </el-form-item>
    </el-form>
    <template #footer>
      <div class="dialog-footer">
        <el-button @click="clickCancel">取消</el-button>
        <el-button type="primary" @click="handleSubmit">保存</el-button>
      </div>
    </template>
    </el-dialog>
</template>

<script setup>
import { ElMessage } from 'element-plus';
import { ArrowDown } from '@element-plus/icons-vue'
import requestUtil,{getServerUrl} from '@/util/request.js'
import router from '@/router';
import { ref } from 'vue';
import avatar from './avatar.vue';
const currentUser = JSON.parse(sessionStorage.getItem("currentUser"))
// 默认头像的路径，你需要将其替换为实际的默认头像路径
const defaultAvatarUrl = getServerUrl() + 'media/userAvatar/default_avatar.jpg';
// 判断用户是否有头像，如果没有则使用默认头像
const squareUrl = currentUser.avatar ? getServerUrl() + 'media/userAvatar/' + currentUser.avatar : defaultAvatarUrl;
const personShow = ref(false)
//个人中心的信息显示及密码修改
let userInfomation = ref({
  id: currentUser.id,
  username: currentUser.username,
  oldPassword: '',
  newPassword: '',
  confirmPassword:'',
})
const pwdRef = ref(null)
const equalToPassword = (rule, value, callback) => {
  if (userInfomation.value.newPassword) {
    if (userInfomation.value.newPassword !== value) {
      callback(new Error("两次输入的密码不一致"));
    } else {
      callback();
    }
  } else {
    callback();
  }
};

const rules = ref({
  username:[{required: true, message: "用户名不能为空", trigger: "blur"}],
  oldPassword: [{required: true, message: "旧密码不能为空", trigger: "blur"}],
  newPassword: [
    {
      validator: (rule, value, callback) => {
        if (userInfomation.value.newPassword) {
          if (value.length < 6 || value.length > 20) {
            callback(new Error("长度在 6 到 20 个字符"));
          } else {
            callback();
          }
        } else {
          callback();
        }
      },
      trigger: "blur"
    }
  ],
  confirmPassword: [
    {
      validator: equalToPassword,
      trigger: "blur"
    }
  ]
});


const handleSubmit = () => {
  pwdRef.value.validate(async (valid) => {
    if (valid) {
      let result = await requestUtil.post("user/updateUserPwd", userInfomation.value);
      let data = result.data;
      if (data.code === 200) {
        // 更新 currentUser 的用户名
        currentUser.username = userInfomation.value.username;
        sessionStorage.setItem("currentUser", JSON.stringify(currentUser));
        ElMessage.success("信息修改成功！")
      } else {
        ElMessage.error(data.errorInfo)
      }
    }
  })
}
// 点击取消
const clickCancel=()=>{
  personShow.value = false
  window.location.reload();// 刷新页面
}
//退出登录
const logout = () => {
    window.sessionStorage.clear()
    router.replace("/")
}
</script>

<style lang="less" scoped>
.el-dropdown-link {
  cursor: pointer;
  color: var(--el-color-primary);
  display: flex;
  align-items: center;
}
.el-dropdown{
    height: 55px;
}
</style>