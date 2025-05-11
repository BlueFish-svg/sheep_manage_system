import { createApp } from 'vue'
import App from './App.vue'
import '@/assets/css/common.css'
import router from './router'
// 导入ElementPlus
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
const app = createApp(App)

import * as ElementPlusIconsVue from '@element-plus/icons-vue'

for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
    app.component(key, component)
}
import zhCn from 'element-plus/es/locale/lang/zh-cn'
import 'wow.js/css/libs/animate.css'
app.use(ElementPlus, {
    locale: zhCn,
})
app.use(router).mount('#app')


