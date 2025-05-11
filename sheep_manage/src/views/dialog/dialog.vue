<template>
    <el-dialog v-model="dialogFormVisible" :title="dialogTitle" width="50%" draggable @close="handleClose">
      <el-form :model="form">
        <!-- 羊只种类选择 -->
        <el-form-item label="羊只种类" :label-width="formLabelWidth">
          <!-- 绑定 v-model 到 form.type -->
          <el-select v-model="form.sheep_type" placeholder="请选择羊只种类">
            <el-option v-for="item in newsheepType" :key="item.id" :label="item.sheep_category_name" :value="item.id" />
          </el-select>
        </el-form-item>
        <!-- 羊只性别选择 -->
        <el-form-item label="羊只性别" :label-width="formLabelWidth">
          <el-select v-model="form.sheep_sex" placeholder="请选择羊只性别">
            <el-option v-for="item in sex" :key="item.id" :label="item.sex_label" :value="item.id" />
          </el-select>
        </el-form-item>
        <!-- 羊龄输入 -->
        <el-form-item label="羊龄" :label-width="formLabelWidth">
          <el-input-number v-model="form.sheep_age" :min="0" :max="20" />
        </el-form-item>
        <!-- 健康状况选择 -->
        <el-form-item label="健康状况" :label-width="formLabelWidth">
          <el-select v-model="form.health_condition" placeholder="请选择健康状况">
            <el-option v-for="item in sheep_health" :key="item.id" :label="item.health_label" :value="item.id" />
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="handleClose">取消</el-button>
          <el-button type="primary" @click="handleConfirm">确认</el-button>
        </div>
      </template>
    </el-dialog>
  </template>
  
<script setup>
import requestUtil from '@/util/request.js'
import { ElMessage } from 'element-plus';
import { ref, watch } from 'vue';
// 控制对话框显示与隐藏
const dialogFormVisible = ref(false);
// 表单标签宽度
const formLabelWidth = '140px';
// 定义 props 来接收父组件传递的数组
const props = defineProps({
  sheepType: {
    type: Array,
      required: true
      },
      dialogFormVisible: {
        type: Boolean,
        default: false,
        required: true
      },
      dialogTitle: {
        type: String,
        default: '',
        required: true
      },
      id: {
        type: Number,
        default: '',
        required: true
      }
      
});
//健康状况定义
let sheep_health = ref([
  { id:1, health_label:"健康" },
  { id:2, health_label: "良好" },
  { id:3,health_label:"患病"},
  { id:4,health_label:"其他"}
])
// 羊只性别定义
let sex = ref([
{ id:1, sex_label:"公羊" },
{ id:2, sex_label: "母羊" }
])
// 通过id查询羊的信息
const initFormData = async (id) => {
  const res = await requestUtil.get("user/id_search_sheep?id=" + id);
  if (res.data.code === 200) {
    const sheepData = res.data.only_sheep;
    form.value = sheepData;
  } else {
    ElMessage.error(res.data.errorInfo)
  }
}
// 定义对话框标题
const dialogTitle = ref("")
watch(() => props.dialogTitle, (newValue) => {
  dialogTitle.value = newValue;
});
 // 表单数据对象
const form = ref({
    id:-1,
    sheep_type: '', // 羊只种类
    sheep_age: 0,   // 羊龄
    sheep_sex: '',  // 羊只性别
    health_condition: '' // 健康状况
 });
// 重置表单数据
const resetForm = () => {
  form.value = {
      id:-1,
      sheep_type: '', // 羊只种类
      sheep_age: 0,   // 羊龄
      sheep_sex: '',  // 羊只性别
      health_condition: '' // 健康状况
    }
}
// 定义可触发的自定义事件
const emits = defineEmits(['close-dialog','initSheepList']);
// 监听父组件传递的 dialogFormVisible 变化
watch(() => props.dialogFormVisible, (newValue) => {
  dialogFormVisible.value = newValue;
  if (newValue) {//对话框打开时
    if (props.id == -1) {//添加模式
      resetForm();
    } else {//编辑模式
      initFormData(props.id)
    }
    
  }
});
// 表单验证事件
const NoneForm = () => {
  if (!form.value.sheep_type){
    ElMessage.error("羊只种类不能为空!");
    return false; // 表单无效，返回 false
    }
  if (!form.value.sheep_sex){
    ElMessage.error("羊只性别不能为空!");
    return false; // 表单无效，返回 false
    }
  if (!form.value.health_condition){
    ElMessage.error("健康状况不能为空!");
    return false; // 表单无效，返回 false
    }
  return true; // 表单有效，返回 true
};
// 确认按钮点击事件处理函数
const handleConfirm = async () => {
    const isValid = NoneForm();
    if (!isValid) {
        return//验证不通过，添加失败
  }
    const res = await requestUtil.post("user/addAndEditSheep", form.value);
    if (res.data.code === 200) {
        ElMessage.success("执行成功！")
        emits('initSheepList');
        resetForm();
    } else {
        ElMessage.error(res.data.errorInfo);
    }
    emits('close-dialog');
};
const handleClose = () => {
  emits('close-dialog');
};
 
  
// 创建一个响应式变量来存储羊只种类数据
const newsheepType = ref([]);
  // 监听 sheepType 的变化
  watch(() => props.sheepType, (newSheepType) => {
    // if (newSheepType.length > 0) {
     
      // 将新的数据赋值给响应式变量
    newsheepType.value = newSheepType;
    // console.log(newsheepType);
    // }
  });
  </script>
  
  <style>
  
  </style>