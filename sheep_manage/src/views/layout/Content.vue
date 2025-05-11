<template>
    <div class="header">
        <div class="icon">
            <el-icon v-if="isClose" @click="change"><Expand /></el-icon>
            <el-icon v-else @click="change"><Fold /></el-icon>
        </div>
        <div class="right">
            <div class="time">{{ CurrentTime }}</div>
            <div class="line">|</div>
            <div class="avatar">
                 <Avatar></Avatar>
            </div>
        </div>
    </div>
    <div class="wrapper">
        <router-view></router-view>
    </div>
</template>

<script setup>
import { onMounted, onUnmounted, ref } from 'vue';
import router from "@/router";
import dayjs from 'dayjs'
import Avatar from '@/components/userCenter.vue';
const props = defineProps({
  isClose: {
    type: Boolean, // 假设 isClose 是布尔类型，根据实际情况修改
    default: false // 可以设置默认值
  }
});
// 定义可以触发的自定义事件
const emit = defineEmits(['change']);
// 切换菜单折叠展开
const change = () => {
    emit('change');
}
//使用 ref 创建响应式数据 CurrentTime
let CurrentTime = ref('')
//定义更新时间的函数
const updateTime = () => {
    // 获取当前时间并格式化为指定格式
    CurrentTime.value=dayjs(new Date()).format('YYYY-MM-DD HH:mm:ss')  
    
}
// 在组件挂载时执行的钩子函数
onMounted(() => {
    // 初始调用一次更新时间函数
    updateTime();
     // 设置定时器，每隔 1 秒调用一次更新时间函数
    const intervalId = setInterval(updateTime, 1000);
    // 存储定时器 ID，以便在组件卸载时清除定时器
    const clearIntervalFn = () => clearInterval(intervalId);
    // 在组件卸载时清除定时器，避免内存泄漏
    onUnmounted(clearIntervalFn);
})
// 退出登录
// const out=() => {
//     router.push('/')
// }
</script>

<style lang="less" scoped>
.header{
    height: 55px;
    line-height: 55px;
    background: #1e78bf;
    color: #fff;
    display: flex;
    .icon{
        font-size: 25px;
        flex: 1;
        i{
            cursor: pointer;
        }
    }
    .right{
        padding-right: 20px;
        display: flex;
        .time{
            font-size: 13px;
        }
        .line{
            padding-left:10px;
            padding-right: 10px;
        }
    }
}
.wrapper{
    margin: 10px;
}

</style>