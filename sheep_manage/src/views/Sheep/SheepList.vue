<template>

  <!-- 添加和搜索 -->
 <div class="app-container">
    <el-row :gutter="20" class="header">
      <el-col :span="7">
        <el-input placeholder="请输入羊的编号..." v-model="queryForm.query" clearable></el-input>
      </el-col>
      <el-button type="primary" :icon="Search" @click="initSheepList">搜索</el-button>
      <el-button type="success" :icon="Plus" @click="addAndEditSheep()">添加羊只</el-button>
      <!-- 删除按钮 -->
      <el-button type="danger" :disabled="delBtnStatus" :icon="Delete" @click="handleDelete(null)">批量删除</el-button>
    </el-row>
    <!-- 表格 -->
    <el-table :data="tableData" stripe style="width: 100%" @selection-change="handleSelectionChange">
    <el-table-column type="selection" width="30"/>
    <!-- <el-table-column prop="id" label="id" width="80" align="center"/> -->
    <el-table-column prop="sheep_id" label="羊只编号" width="300" align="center"/>
    <el-table-column prop="sheep_type" label="羊只种类"  align="center"/>
    <el-table-column prop="sheep_sex" label="羊只性别"  align="center"/>
    <el-table-column prop="sheep_age" label="羊龄" align="center"/>
    <el-table-column prop="health_condition" label="健康状况"  align="center"/>
    <el-table-column prop="action" label="操作" width="250" fixed="right" align="center">
        <template #default="scoped">
            <el-button size="small" :icon="EditPen" type="primary" @click="addAndEditSheep(scoped.row.id)">编辑</el-button>
            <el-button size="small" :icon="Delete" type="danger" @click="handleDelete(scoped.row.id)">删除</el-button>
        </template>
    </el-table-column>
  </el-table>
   <!-- 分页 -->
   <el-pagination
      v-model:current-page="queryForm.pageNum"
      v-model:page-size="queryForm.pageSize"
      :page-sizes="[5, 10, 15, 20]"
      layout="total, sizes, prev, pager, next, jumper"
      :total="total"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
    />
<!-- 添加编辑和添加对话框 -->
<Dialog :sheepType="sheepType" :dialogFormVisible="dialogFormVisible" :id="id" :dialogTitle="dialogTitle" @close-dialog="closeDialog" @initSheepList="initSheepList"></Dialog>
  </div>
<!-- 删除对话框 -->
<el-dialog
    v-model="dialogVisible"
    title="确定删除吗?"
    width="500"
    draggable
  >
  <span>删除之后不能恢复，请谨慎操作</span>
    <template #footer>
      <div class="dialog-footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="confirmDelete">
          删除
        </el-button>
      </div>
    </template>
  </el-dialog>
</template>

<script setup> 
import { ref } from "vue"
import requestUtil from '@/util/request.js'
import { ElMessage,ElMessageBox } from 'element-plus';
import dayjs from 'dayjs';
import { Delete, EditPen, Search, Plus } from "@element-plus/icons-vue"
import Dialog from "../dialog/dialog.vue";

// 全局搜索功能开始
// 表格数据初始化
const tableData = ref([])
const total=ref(0)
const queryForm = ref({
  query: '',
  pageNum:1,
  pageSize:10,
})
const sheepType=ref([111])
const initSheepList = async () => {
  const res = await requestUtil.post("user/searchList", queryForm.value)
  sheepType.value = res.data.sheepType
  tableData.value = res.data.sheepList
  total.value=res.data.total
}

const handleSizeChange = (pageSize) => {
  queryForm.value.pageSize = pageSize
  queryForm.value.pageNum=1
  initSheepList()
}
const handleCurrentChange = (pageNum) => {
  queryForm.value.pageNum = pageNum
  initSheepList()
}
initSheepList()
// 全局搜索功能结束
const dialogTitle = ref('')
const id = ref(-1)
// 添加功能
const dialogFormVisible=ref(false)
const addAndEditSheep = (sheep_id) => {
  if (sheep_id) {
    id.value=sheep_id
    dialogTitle.value="编辑羊只"
   
  } else {
    id.value=-1
    dialogTitle.value="添加羊只"
  }
  dialogFormVisible.value = true
}
// 关闭对话框
const closeDialog = () => {
  dialogFormVisible.value = false
}
// 删除功能的实现----------------------------
const delBtnStatus = ref(true)
const multipleSelection = ref([])
const handleSelectionChange = (selection) => {
  // console.log("勾选了")
  // console.log(selection)
  multipleSelection.value = selection;
  delBtnStatus.value = selection.length == 0;
}
const dialogVisible = ref(false)
const delete_sheep_ids=[]
const handleDelete = (id) => {
  dialogVisible.value = true
  var ids = []
  if (id) {
    ids.push(id)
  } else {
    multipleSelection.value.forEach(row => {
      ids.push(row.id)
    });
  }
  // 将 ids 保存到一个变量中，供后续删除操作使用
  delete_sheep_ids.value = ids;
}
// 删除操作
const confirmDelete = async () => {
  const res = await requestUtil.del("user/delete_sheep", delete_sheep_ids.value)
  if (res.data.code === 200) {
    ElMessage.success("删除成功")
    dialogVisible.value = false
    initSheepList()
  } else {
    ElMessage.error(res.data.errorInfo)
    dialogVisible.value=false
  }
}
</script>

<style scoped>
.header {
  padding-bottom: 16px;
  box-sizing: border-box;
}
.el-pagination {
  float: right;
  padding: 20px;
  box-sizing: border-box;
}

:v-deep th.el-table__cell {
  word-break: break-word;
  background-color: #f8f8f9 !important;
  color: #515a6e;
  height: 40px;
  font-size: 13px;

}
.el-tag--small {
  margin-left: 5px;
}

</style>