<template>
  <div class="app-container">
    <el-row :gutter="20" class="header">
      <el-col :span="7">
        <el-input placeholder="请输入种类名称..." v-model="queryForm.query" clearable></el-input>
      </el-col>
      <el-button type="primary" :icon="Search" @click="initSheepList">搜索</el-button>
      <el-button type="success" :icon="Plus" @click="dlgAddShow=true">添加种类</el-button>
    </el-row>

    <el-table :data="tableData" stripe style="width: 100%">
    <el-table-column prop="id" label="id" width="180" align="center"/>
    <el-table-column prop="sheep_category_name" label="种类名称" width="180" align="center"/>
    <el-table-column prop="sheep_category_address" label="地址区域"  align="center"/>
    <el-table-column prop="create_time" label="添加时间"  align="center"/>
    <el-table-column prop="action" label="操作" width="250" fixed="right" align="center">
        <template #default="scoped">
            <el-button size="small" :icon="EditPen" type="primary" @click="handleEdit(scoped.row)">编辑</el-button>
            <el-button size="small" :icon="Delete" type="danger" @click="handledel(scoped.row.id)">删除</el-button>
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
    <!-- 添加种类的对话框 -->
    <el-dialog v-model="dlgAddShow" title="添加羊只种类" width="600">
    <el-form :model="addData">
      <el-form-item label="种类名称">
        <el-input v-model="addData.sheep_category_name" autocomplete="off" placeholder="请输入种类名称"  />
      </el-form-item>
      <el-form-item label="地址区域">
        <el-input v-model="addData.sheep_category_address" autocomplete="off" placeholder="请输入地址区域" />
      </el-form-item>
      <el-form-item label="添加时间">
        <el-date-picker v-model="addData.create_time" autocomplete="off" placeholder="请输入添加时间" />
      </el-form-item>
    </el-form>
    <template #footer>
      <div class="dialog-footer">
        <el-button @click="dlgAddShow = false">取消</el-button>
        <el-button type="primary" @click="saveAddDate">确认</el-button>
      </div>
    </template>
    </el-dialog>

    <!-- 编辑种类的对话框 -->
    <el-dialog v-model="dlgEditShow" title="编辑羊只种类" width="600">
    <el-form :model="editData">
      <el-form-item label="种类名称">
        <el-input v-model="editData.sheep_category_name" autocomplete="off" placeholder="请输入种类名称"  />
      </el-form-item>
      <el-form-item label="地址区域">
        <el-input v-model="editData.sheep_category_address" autocomplete="off" placeholder="请输入地址区域" />
      </el-form-item>
      <el-form-item label="添加时间">
        <el-date-picker v-model="editData.create_time" autocomplete="off" placeholder="请输入添加时间" />
      </el-form-item>
    </el-form>
    <template #footer>
      <div class="dialog-footer">
        <el-button @click="dlgEditShow = false">取消</el-button>
        <el-button type="primary" @click="saveEditData">确认</el-button>
      </div>
    </template>
    </el-dialog>
  </div>
    
</template>

<script setup>
import { ref } from "vue"
import requestUtil from '@/util/request.js'
import { ElMessage,ElMessageBox } from 'element-plus';
import dayjs from 'dayjs';
import { Delete, EditPen, Search, Plus } from "@element-plus/icons-vue"
// 添加功能开始------------------------
// 是否显示添加的窗口
const dlgAddShow=ref(false)
let addData = ref({
      sheep_category_name:'',
      sheep_category_address: '',
      create_time:'',
})
// 保存羊的种类数据
const saveAddDate = async () => {
  if (!addData.value.sheep_category_name) {
        ElMessage.error("请输入种类名称");
        return;
  }
  if (!addData.value.sheep_category_address) {
        ElMessage.error("请输入地址区域");
        return;
  }
  if (!addData.value.create_time) {
        ElMessage.error("请输入添加时间");
        return;
    }
  addData.value.create_time = dayjs(addData.value.create_time).format('YYYY-MM-DD');
  try {
    const res = await requestUtil.post("user/sheep", addData.value);
    if (res.data.code === 201) {
      //添加成功
      ElMessage.success(res.data.message);
      dlgAddShow.value = false;//关闭对话框
      // 重置 addData
      addData.value = {
        sheep_category_name: '',
        sheep_category_address: '',
        create_time: '',
      };
      initSheepList();//刷新表格数据
    } else {
      // 添加失败
      ElMessage.error(res.data.message)
    }
  } catch (error) {
    ElMessage.error("添加失败，请稍后再试！");
  }
}
// 添加功能结束------------------
// 全局搜索和单独搜索开始-----------------
const tableData = ref([])
const total=ref(0)
const queryForm = ref({
  query: '',
  pageNum:1,
  pageSize:10,
})
const initSheepList = async () => {
  const res = await requestUtil.post("user/search", queryForm.value)
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
// 全局搜索和单独搜索结束-----------------
// 编辑功能开始------------
// 是否显示编辑的窗口
const dlgEditShow = ref(false)
// 初始化数据
let editData = ref({
      sheep_category_name:'',
      sheep_category_address: '',
      create_time:'',
})
// 处理编辑操作
const handleEdit = (row) => {
  editData.value = {
    ...row,
    create_time: dayjs(row.create_time).toDate()
  }
  dlgEditShow.value = true
}
// 保存编辑数据
const saveEditData = async () => {
  if (!editData.value.sheep_category_name) {
        ElMessage.error("请输入种类名称");
        return;
  }
  if (!editData.value.sheep_category_address) {
        ElMessage.error("请输入地址区域");
        return;
  }
  if (!editData.value.create_time) {
        ElMessage.error("请输入添加时间");
        return;
    }
  editData.value.create_time = dayjs(editData.value.create_time).format('YYYY-MM-DD');
  try {
    const res = await requestUtil.put(`user/sheep/${editData.value.id}`, editData.value);
    if (res.data.code === 200) {
      //编辑成功
      ElMessage.success(res.data.message);
      dlgEditShow.value = false//关闭对话框
      // 重置 editData
      editData.value = {
        sheep_category_name: '',
        sheep_category_address: '',
        create_time: '',
      }
      initSheepList()//刷新表格数据
    }else {
      //编辑失败
      ElMessage.error(res.data.message)
    }
  } catch(error) {
    ElMessage.error("编辑失败，请稍后重试")
  }
};

// 删除功能开始---------------
const clickdel=async(id)=>{
  try {
        const res = await requestUtil.del(`user/sheep/${id}`);
        if (res.status === 204) {
            ElMessage.success("删除成功");
            initSheepList(); // 刷新表格数据
        } else {
          //删除失败
            ElMessage.error("删除失败，请稍后重试。");
        }
    } catch (error) {
        ElMessage.error("删除失败，请稍后重试。");
    }
}


//点击删除的方法
const handledel=(id)=>{
    // 给出确认提示
    ElMessageBox.confirm(
      '删除之后不可恢复，请确认是否要进行该操作?',
      '提示',
      {
        confirmButtonText: '确认',
        cancelButtonText: '取消',
        type: 'warning',
      }
    )
      .then(() => {
        //点击确认，执行下面的代码
        //调用接口
        clickdel(id)
      })
      .catch(() => {
        //点击取消，执行下面的代码
        ElMessage({
          type: 'info',
          message: '已取消删除操作',
        })
      })
}

//删除功能结束-------------
</script>

<style lang="less" scoped>
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
