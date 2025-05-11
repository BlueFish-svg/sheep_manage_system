<template>
    <div class="menu">
        <MyMenu :isClose="isClose"></MyMenu>
    </div>
    <div class="content" :class="{active:isClose}">
        <Content :isClose="isClose" @change="change"></Content>
    </div>
</template>

<script setup>
import { ref } from 'vue';
import MyMenu from './MyMenu.vue';
import Content from './Content.vue';
// 定义变量
let isClose = ref(false)
// 修改变量
const change = () => {
    isClose.value=!isClose.value
}
</script>

<style scoped>
.menu{
    position: fixed;
    left: 0;
    top: 0;
    bottom: 0;
    background: #112f50;
}
.content{
    padding-left: 200px;
}
.active{
    padding-left: 64px;
}
</style>