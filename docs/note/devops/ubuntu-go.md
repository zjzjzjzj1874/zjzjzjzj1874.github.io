<article-title title="Ubuntu安装Go环境"></article-title>

<article-meta date="2023年09月06日"></article-meta>

--- 

### 清理环境

如果原来有安装golang的环境,清理一下,没有的话则跳过此步骤
```shell
sudo apt-get remove golang-go
sudo apt-get remove --auto-remove golang-go
rm -rvf /usr/local/go/
```

### 安装Golang

* 下载并解压golang压缩包
这里以1.18.2的版本为示例,需要其他的可以先查询再替换
```shell
wget -c https://dl.google.com/go/go1.18.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
```

* 加入环境变量
```shell
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.zshrc
source ~/.zshrc
```
如果命令行使用的是其他,把zshrc替换成其他的即可.

* 验证
```shell
go version
```

* 其他
将代理添加到全局
```shell
echo export GOPROXY="https://goproxy.cn,direct" >> ~/.zshrc
```