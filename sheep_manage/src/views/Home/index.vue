<template>
<div class="container">
   <div class="left-container">
      <div class="all_amount">
          <div class="amount_icon wow bounce "><el-icon style="width: 100px;"><Histogram style="width: 100px;height: 100px;"/></el-icon>
            <i style="font-size: 25px;padding-top: 40px;">羊只总数量</i>
          </div>
          <div class="amount">
            <!-- <i style="line-height: 120px; font-size:70px;color: #fff;">{{ total_amount }}</i> -->
             <countTo :startVal="0" :endVal="total_amount" :duration="6000" style="line-height: 120px; font-size:70px;color: #fff;">{{ total_amount }}</countTo>
          </div>
      </div>
      <div class="sex_amount wow bounceIn">
        <pie></pie>
      </div>
   </div>
   <div class="right-container wow slideInRight">
      <gauchart></gauchart>
   </div>
  
</div>
<div class="footer ">
    <p>2025年1月10日-2025年2月19日 320243443 乔瑞强（作者） 新疆农业大学 计算机与信息工程学院</p>
  </div>
</template>

<script setup>
import { CountTo } from 'vue3-count-to';
import { ref, onMounted } from 'vue';
import requestUtil from '@/util/request.js'
import pie from './pie.vue';
import gauchart from './barchart.vue';
import WOW from 'wow.js'
onMounted(() => {
    var wow = new WOW({
    boxClass: 'wow',
    animateClass: 'animated',
    offset: 0,
    mobile: true,
    live: true
    });
wow.init();
})
let total_amount=ref(0)
const SearchSheepList = async () => {
  const res = await requestUtil.get("user/search_data");
  total_amount.value = res.data.total_count;
}
SearchSheepList()
</script>

<style lang="less" scoped>
.container{
  width: 100%;
  height: 600px;
  display: flex;
}
.left-container{
  width: 300px;
}
.right-container{
  flex: 1;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5);
  border-radius: 5px;
  margin-left: 10px;
}
.all_amount{
  width: 100%;
  background-color: #4889b8;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5);
  border-radius: 5px;
  height: 295px;
}
.amount_icon{
  width: 100%;
  height: 120px;
  display:flex;
  justify-content: center;
  align-items: center;
}
.amount{
  width: 100%;
  height: 120px;
  text-align: center;
}
.sex_amount{
  width: 100%;
  height: 295px;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5);
  border-radius: 5px;
  margin-top: 10px;
}
.footer{
  width: 100%;
  color: #bebebe;
  padding-top: 10px;
  text-align: center;
  font-size: 18px;
}
</style>