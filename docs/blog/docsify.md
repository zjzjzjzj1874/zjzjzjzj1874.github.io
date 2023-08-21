
<article-title title="Docsify构建站点"></article-title>

<article-meta date="2023年7月21日"></article-meta>

--- 
## 快速开始
确保自己环境中有 Node 和 NPM ，安装全局的`docsify-cli`工具，方便创建及在本地预览生成的文档。
```shell
npm i docsify-cli -g
```

## 初始化项目
```shell
docsify init ./docs --theme dark
```

## 查看文件结构
```shell
tree -a
```
显示如下:
```shell
├── docs
│   ├── .nojekyll
│   ├── README.md
│   └── index.html
```
- `index.html`入口文件
- `README.md`作为主页内容渲染
- `.nojekyll`用于阻止 GitHub Pages 忽略掉下划线开头的文件

## 预览服务
启动本地开发服务器并预览

```shell
docsify serve docs -p 8080
```
然后访问http://localhost:8080

> 更多工具行命令可以参考[docsify-cli文档](https://github.com/docsifyjs/docsify-cli)


## CI/CD集成
如果您使用 githubio ，则将代码推送到仓库即可；
如果您使用自己的站点部署，可以集成 CI/CD；
后续将会慢慢介绍如何将 CI/CD 流程集成到项目中。

## 参考文档

* [中文官方网站](https://docsify.js.org/#/zh-cn/)
* [官方网站](https://docsify.js.org/#/)