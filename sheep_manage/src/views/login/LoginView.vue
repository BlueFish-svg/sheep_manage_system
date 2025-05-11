<template>
 <div class="container">
    <h1>用户登录</h1>
    <el-form :model="loginForm" ref="loginRef" :rules="loginRules">
    <el-form-item prop="username">
      <el-input  type="text" placeholder="请输入用户名" 
      prefix-icon="User"  v-model="loginForm.username" autocomplete="off"/>
    </el-form-item>
    <el-form-item prop="password">
      <el-input type="password" placeholder="请输入密码" 
      prefix-icon="Lock"  v-model="loginForm.password" show-password autocomplete="new-password"/>
    </el-form-item>
    <el-form-item>
    <el-button type="primary" @click.prevent="handleLogin">登录</el-button>
    </el-form-item>
    <el-form-item label="记住密码">
      <el-switch v-model="loginForm.rememberPassword"/>
    </el-form-item>
  </el-form>
 </div>
</template>

<script setup>
import Cookies from "js-cookie";
import { encrypt, decrypt } from "@/util/jsencrypt";
import requestUtil from '@/util/request.js'
import qs from 'qs'
import { ElMessage } from 'element-plus';
import {ref } from 'vue';
import router from "@/router";
let loginForm = ref({
    username: "",
    password: "",
    rememberPassword:false,
})
const loginRef=ref(null)
const loginRules = {
    username: [{required: true, trigger: "blur", message: "请输入您的账号"}],
    password: [{ required: true, trigger: "blur", message: "请输入您的密码" }],
};
const handleLogin = async () => {
    // 检查用户名和密码是否为空
    if (!loginForm.value.username) {
        ElMessage.error("请输入用户名");
        return;
    }
    if (!loginForm.value.password) {
        ElMessage.error("请输入密码");
        return;
    }

    await loginRef.value.validate(async (valid) => {
        if (valid) {
            let result = await requestUtil.post("user/login?" + qs.stringify(loginForm.value))
            // qs.stringify(loginForm.value)：将 loginForm.value 对象序列化为查询字符串。
            // 例如，如果 loginForm.value 是 { username: 'user1', password: 'pass1' }，
            // 那么 qs.stringify(loginForm.value) 会返回 username = user1 & password=pass1。
            let data = result.data
            if (data.code == 200) {
                ElMessage.success(data.info)
                window.sessionStorage.setItem("token", data.token)
                window.sessionStorage.setItem("currentUser", JSON.stringify(data.user))
                // 忘记密码功能
                // 勾选了需要记住密码设置在 cookie 中设置记住用户名和密码
                if (loginForm.value.rememberPassword) {
                Cookies.set("username", loginForm.value.username, { expires: 30 });
                Cookies.set("password", encrypt(loginForm.value.password), { expires: 30 });
                Cookies.set("rememberMe", loginForm.value.rememberMe, { expires: 30 });
                } else {
                // 否则移除
                Cookies.remove("username");
                Cookies.remove("password");
                Cookies.remove("rememberMe");
                }
                // 登录成功后跳转
                router.push("/layout")
            }
            else {
                ElMessage.error(data.info)
            }
        }
        else {
            console.log("验证失败")
        }
    })
}

// 从Cookies拿值，其实就是初始化
function getCookie() {
  const username = Cookies.get("username");
  const password = Cookies.get("password");
  const rememberMe = Cookies.get("rememberMe");
  loginForm.value = {
    username: username === undefined ? loginForm.value.username : username,
    password: password === undefined ? loginForm.value.password : decrypt(password),
    rememberMe: rememberMe === undefined ? false : Boolean(rememberMe)
  };
}

getCookie();
</script>

<style scoped>
.container{
    width: 600px;
    height: 450px;
    margin: 125px auto;
    display: flex;
    flex-direction: column;
    text-align: center;
}
.el-form{
    display: flex;
    margin-top: 30px;
    flex-direction: column;
    align-items:center;
}
.el-input{
    width: 500px;
    height: 40px;
}
.el-button{
    width: 500px;
    height: 40px;
    font-size: 16px;
}
.el-form-item{
    margin-bottom: 20px;
}
</style>