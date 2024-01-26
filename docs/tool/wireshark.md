
<article-title title="WireShark安装及问题"></article-title>

<article-meta created="2023年12月29日" updated="2023年12月29日"></article-meta>

---  

[//]: # ( TODO 这里可以换成抓包的工具)

### 安装
* 到[下载](https://www.wireshark.org/download.html)页面根据系统选择需要下载的版本

* 下载后双击安装

* 安装完成后打开.

### 报错
- You do not have permission to capture on device "en6". ((cannot open BPF device) /dev/bpf0: Permission denied)
  - [解决](https://ask.wireshark.org/question/16508/chmodbpf-permission-denied-on-macos-10154-catalina/),更改权限即可
  ```shell
  sudo chmod g+r /dev/bpf*
  
  sudo chgrp admin /dev/bpf*
  ```
