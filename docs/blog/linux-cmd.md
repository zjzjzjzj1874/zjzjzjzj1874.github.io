
<article-title title="Linux常用命令"></article-title>

<article-meta date="2023年8月10日"></article-meta>

---

### 基础命令

#### open

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