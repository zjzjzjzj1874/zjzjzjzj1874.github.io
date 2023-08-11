
<article-title title="Linux常用命令"></article-title>

<article-meta date="2023年8月10日"></article-meta>

---

### 基础命令

#### open
MacOS下面打开文件,文件夹和应用的命令,类似与Windows中的start

* 打开文件
```shell
open file.txt
```

* 打开文件夹
```shell
open ~/GolandProjects
```

* 打开应用程序
```shell
open -a "Goland"
```

* 使用默认浏览器打开url
```shell
open https://www.baidu.com
```

* 使用指定程序打开文件
```shell
open -a "TextEdit" file.txt
```

* 打开Finder窗口
```shell
open .
```

* MacOS中打开Chrome浏览器网页
    ```shell
    open -a "Google Chrome" 'https://www.baidu.com'
    ```
    当然,如果您再配合alias使用,效果更佳,如:
    ```shell
    echo "alias open_baidu=\"open -a 'Google Chrome' 'https://www.baidu.com'\"" >> ~/.zshrc
    
    source ~/.zshrc
    
    open_baidu 
    ```
    您就会发现Google浏览器的百度页面为您打开了.
* Goland项目打开
   ```shell
  open -a "GoLand" /path/to/your/project
  ```
  配合alias使用,如:
  ```shell
  echo "alias op_shell=\"open -a 'Goland' ~/GolandProjects/shell\"" >> ~/.zshrc
      
  source ~/.zshrc
  
  op_shell 
  ```