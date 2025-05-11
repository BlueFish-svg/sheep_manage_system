<template>
  <el-menu
    :default-active="route.path"
    class="el-menu-vertical-demo"
    :collapse="isClose"
    active-text-color="#ffd04b"
    background-color="#112f50"
    text-color="#fff"
    router
  >
  <el-menu-item> <template #title> <span>智能羊场管理系统</span></template></el-menu-item>
  <el-menu-item index="/layout"> 
      <el-icon><home-filled /></el-icon> <span>系统首页</span>
  </el-menu-item>
  
    <el-sub-menu index="/sheeps">
      <template #title>
        <el-icon><Platform /></el-icon>
        <span>羊场管理</span>
      </template>
      <el-menu-item-group>
        <el-menu-item index="/sheeps/Category"><el-icon><Grid /></el-icon>种类列表</el-menu-item>
        <el-menu-item index="/sheeps/sheeplist"><el-icon><Histogram /></el-icon>羊只列表</el-menu-item>
      </el-menu-item-group>
    </el-sub-menu>
   
  </el-menu>
</template>

<script setup>

import { useRoute } from 'vue-router';
const props = defineProps({
  isClose: {
    type: Boolean, // 假设 isClose 是布尔类型，根据实际情况修改
    default: false // 可以设置默认值
  }
});
// 定义开关
// const isCollapse = ref(false)
//使用路由
const route = useRoute()
</script>

<style lang="less" scoped>
.el-menu{
  border-right: none;
}
.el-menu-vertical-demo:not(.el-menu--collapse){
  width: 200px;
  min-height: 400px;
}
</style>


