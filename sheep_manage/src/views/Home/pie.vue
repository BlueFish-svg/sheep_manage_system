<template>
    <!-- 为 ECharts 准备一个定义了宽高的 DOM -->
    <div ref="chart" style="width: 300px;height:100%;"></div>
 </template>
 
 <script setup>
import * as echarts from 'echarts'
import { ref, onMounted } from 'vue';
import requestUtil from '@/util/request.js'
 const chart = ref();//创建DOM引用
 onMounted(() => {
  // 基于准备好的dom，初始化echarts实例
  var myChart = echarts.init(chart.value);
  var option;
   option = {
      // 将 title 配置项移到根级别
      title: {
      show: true,
      text: '公羊母羊总数量',
      left: 'center',
      top: '87%',
      textStyle: {
        fontSize: 20,
        color: '#5c7bd9',
        // fontWeight: 'bold'
      }
    },
    tooltip: {
      trigger: 'item'
    },
    legend: {
      top: '5%',
      left: 'center'
    },
    series: [
      {
        name: 'Access From',
        type: 'pie',
        radius: ['40%', '70%'],
        avoidLabelOverlap: false,
        label: {
          show: false,
          position: 'center'
        },
        emphasis: {
          label: {
            show: true,
            fontSize: 40,
            fontWeight: 'bold'
          }
        },
        labelLine: {
          show: false
        },
        data: [
          { value: 0, name: '公羊' },
          { value: 0, name: '母羊' },
        ]
      }
    ]
  };

  option && myChart.setOption(option);
  const SearchSheepList = async () => {
  const res = await requestUtil.get("user/search_data");
  // 更新 option 中的数据
    option.series[0].data[0].value = res.data.male_sheep_count;
    option.series[0].data[1].value = res.data.female_sheep_count;
    // 重新设置图表选项
    myChart.setOption(option);
  }
SearchSheepList()
})
 </script>
 
 <style>
 
 </style>
