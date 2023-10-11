
<article-title title="VitePress构建站点"></article-title>

<article-meta created="2023年7月21日" updated="2023年7月21日"></article-meta>

--- 
## 环境准备
确保自己环境中有 Node 和 NPM（Yarn也行）

## 初始化项目
```shell
npx create-vitepress my-blog
# 或者使用 yarn：
# yarn create vitepress my-blog
```

## 依赖安装
进入新生成的文件夹并安装依赖
```shell
cd my-blog
npm install # yarn install # 也是可以的
```

## 预览
启动本地开发服务器
```shell
npm run dev   
```
然后访问 http://localhost:3000

## 编辑文档
接下来，你可以根据需要进行进一步的自定义和编辑，包括样式、布局、主题、插件等

## 构建静态站点:
```shell
npm run build
```
将生成的`dist`目录放到你个人博客即可.

## 流水线构建
如果您使用 githubio，则将代码推送到仓库即可；
如果您使用自己的站点部署，可以集成 CI/CD；
后续将会慢慢介绍如何将 CI/CD 流程集成到项目中。

## 参考文档
* [中文官方网站](https://vitejs.cn/vitepress/)
* [官方网站](https://vitepress.dev/)
* [其他](https://vitepress.dev/reference/site-config)