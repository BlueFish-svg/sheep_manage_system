import { createRouter, createWebHashHistory } from 'vue-router'
import Layout from '@/views/layout'
import Home from '@/views/Home/index.vue'
// 羊只
const Sheeps = () => import('@/views/Sheep')
const SheepList = () => import('@/views/Sheep/SheepList.vue')
const Category = () => import('@/views/Sheep/Category.vue')

const routes = [
  {
    path: '/layout',
    component: Layout,
    children: [
      {
        path: '/layout',
        name: 'home',
        component: Home,
      },
      {
        path: '/sheeps',
        component: Sheeps,
        children: [
          {
            path: 'Category',
            name: 'Category',
            component: Category,//羊只种类
          },
          {
            path: 'sheeplist',
            name: 'sheeplist',
            component: SheepList,//羊只
          },

        ]
      }
    ]
  },
  {
    path: '/',
    name: 'login',
    component: () => import('../views/login/LoginView.vue'),
  },


]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})

export default router
