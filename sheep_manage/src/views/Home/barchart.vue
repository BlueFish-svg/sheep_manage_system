<template>
    <div ref="chart" style="width: 100%;height:95%;"></div>
</template>
<script setup>
import * as echarts from 'echarts';
import { onMounted, ref } from 'vue';
import requestUtil from '@/util/request.js'
const chart = ref();
onMounted(() => {
var myChart = echarts.init(chart.value);
var option;
option = {
    title: {
      show: true,
      text: '各个羊只种类数量柱状图',
      left: 'center',
      top: '1%',
      textStyle: {
        fontSize: 20,
        color: '#5c7bd9',
      }
    },
  tooltip: {
    trigger: 'axis',
    axisPointer: {
      type: 'shadow'
    }
  },
  grid: {
    left: '3%',
    right: '4%',
    bottom: '3%',
    containLabel: true
  },
  xAxis: [
  {
    type: 'category',
    data:[], // 种类名称
    axisTick: {
      alignWithLabel: true
    },
    axisLabel: {
      formatter: function (value) {
        // 确保返回有效的字符串
        return value.length > 3 ? value.slice(0, 3) + '...' : value;
      },
      show: true // 确保显示标签
    }
  }
],
  yAxis: [
    {
      type: 'value'
    }
  ],
  series: [
    {
      name: '数量',
      type: 'bar',
      barWidth: '60%',
      data: []
    }
  ]
};

    option && myChart.setOption(option);
    const SearchSheepCategory = async () => {
        const res = await requestUtil.get("user/bar_searchData");
        console.log("res", res)
        option.xAxis[0].data = res.data.categories; // 种类名称
        option.series[0].data = res.data.counts; // 每种羊的数量
        // 重新设置图表选项
        myChart.setOption(option);
    }
    SearchSheepCategory()
})

</script>

<style>

</style>