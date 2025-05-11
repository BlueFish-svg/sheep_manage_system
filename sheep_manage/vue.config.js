const { defineConfig } = require('@vue/cli-service');
transpileDependencies: true

// module.exports = defineConfig({
//   transpileDependencies: true,
//   devServer: {
//     proxy: {
//       '/': {
//         target: 'http://localhost:8000', // 后端服务器地址
//         changeOrigin: true, // 允许跨域
//         pathRewrite: {
//           '^/': '' // 重写路径
//         }
//       }
//     }
//   }
// });