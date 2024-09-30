<article-title title="awk使用教程"></article-title>

<article-meta created="2024年9月30日" updated="2024年9月30日"></article-meta>

--- 

## 概念
awk起源于grep和sed；awk脚本一般是利用shell包装器来调用。shell包装器是一个shell脚本，它通常包含调用awk的命令行以及awk解释的脚本。
* awk与sed共同点
    * 调用语法相似
    * 面向字符流，从文本文件中，一次一行读取，并将输出直接送到标准输出；
    * 使用正则表达式进行模式匹配
    * 允许用户在脚本中指定指令


## 功能
下面是awk能够完成的一些功能
* 将文本文件看作是由记录和字段组成的文本数据库；
* 使用变量操作数据库；
* 使用算术和字符串操作符；
* 使用普通的程序设计结构，例如循环和条件；
* 生成格式化报告
* 定义函数
* 从脚本中执行Unix命令
* 处理Unix命令结果
* 更巧妙地处理命令行的参数
* 更容易处理多个输入流


## 使用
`awk [ -F fs ] [ -v var=value ] [ 'prog' | -f progfile ] [ file ...  ]`

### awk运行方式
* 命令行方式+文件
  `awk [options] '[Pattern]{Action}' file1 [file2]`
* 命令行方式+管道
  `cat file | awk [options] '[Pattern]{Action}'`
* 脚本方式+执行权限
  将以下内容保存到`test1.awk`中，并赋予执行权限`sudo chmod +x test1.awk`
```bash
#!/usr/bin/awk -f
# 使用Begin指令字符串来设定FS内置变量，不能用'-F'在文件中指定
BEGIN { FS=":"}
{
	print $1
}
```
使用方式：`./test1.awk file1`
* 脚本方式-无需执行权限
  以下内容保存到`test2.awk`中，无须执行权限；

```
#!/usr/bin/awk
BEGIN {}
{
	print $1
}
```
使用方式(相当于把脚本中的`#!/usr/bin/awk -f`的`-f`拿到外面了)：`awk -f test2.awk file`

### 基本用法
awk  {option} filename
awk的测试文件：`awk.txt`
```
Hello: World!
Awk Usage:.
Linux: command.
Time: goes by.
```

* 按照每一行打印：`print`是打印命令，`$0`是当前行
  `cat awk.txt | awk '{print $0}'`
  输出
```
Hello: World!
Awk Usage:.
Linux: command.
Time: goes by.
```

* `awk`会根据空格和制表符，将每一行分割成若干字段，`$0`代表整行,`$1`,`$2`,`$3`分别代表第一个、第二个、第三个字段...
  `cat awk.txt | awk '{print $1}'`
  输出：
```
Hello:
Awk
Linux:
Time:
```
* 使用自定义分隔符 -F指定
  `cat awk.txt | awk -F ':' '{print $1}'`
  输出
```
Hello
Awk Usage
Linux
Time
```

### 变量

#### 指定变量方式
* 通过选项指定(-F)
* 通过内置变量指定(-F对应的内置变量为`FS`)
* 举例：
```bash
# 选项指定
tail -n 5 /etc/passwd | awk -F '{print $1}'
# 内置变量指定-选项指定最终还是会被赋值给内置变量
tail -n 5 /etc/passwd | awk -v FS=":" 'print $1'
```
> 命令行中，需要 `-v` 申明是对内置变量赋值，如果在代码块`{}`中，或者脚本方式就无需`-v`指定。

#### 变量类型
* -F：分隔符是`--field-separator=`的简写；分隔符分为输入分隔符(FS=Field Separator)和输出分隔符(Output Field Separator)；输入可以通过选项和内置变量指定；但是输出分隔符只能通过内置变量指定；
* NF(Number of Fields)：当前行字段个数，`$NF`表示最后一个字段，则倒数第二个`$(NF-1)`；
* NR(Number of Records)：表示当前行号，`Records`改成`Rows`可能更好理解；
* FNR(Number of Record of File)：各文件分别计数的行号，只有在处理多个文件的时候才能体现`FNR`与`NR`的区别；
* FILENAME：当前文件名，同时处理多个文件，可以用来区分属于哪个文件；
* FS(Field Separator)：字段分隔符，默认是空格和制表符，使用：`-F ','`
* OFS(Output Field Separator)：输出字段的分隔符，用于打印时分割字段，默认是空格；
* RS(Record Separator)：行分隔符，用于分割每一行，默认是换行符；
* ORS(Ouput Record Separator)：输出记录的分隔符，用于打印时分割记录，默认是换行符；
* OFMT(Output Format)：数字输出的格式，默认是%.6f；
* ARGC(Arguments Count)：命令行参数个数；
* ARGV(Arguments Variables)：数组，保存的是命令行所给定的各参数；
> 更多变量可以使用`man awk`查看

#### Example
`$1`,`$2`表示第一个，第二个变量，`NF`表示每行有多少字段，所以`$NF`表示最后一个字段;`$(NF-1)`代表倒数第二个...
* 打印最后一个字段，带上行号
  `cat awk.txt | awk '{print NR ":" $NF}'`
```
1:World!
2:Usage:.
3:command.
4:by.
```
* 输出多列：打印第一个和最后一个
  `cat awk.txt | awk '{print $1, $NF}'`
  输出：($1, $NF)中的逗号，表示用空格分隔输出
```
Hello: World!
Awk Usage:.
Linux: command.
Time: by.
```
* 输出多列，指定输出分隔符使用`|`
  命令：`awk -v OFS=" | " '{print $1,$NF}' user.txt`
```bash
张三 | 22
李四 | 23
小芳 | 18
```
上述命令等效于：`awk '{print $1 " | " $NF}' user.txt`
* 打印自定义字符串
  `awk '{print "姓名：", $1}' user.txt`
```
姓名： 张三
姓名： 李四
姓名： 小芳
```
* 多个文件打印文件名，行号，多列打印
  打印所有以`txt`结尾的文件：`awk '{print FILENAME" | " FNR":" $1 "," $NF}' *.txt`
```
test.txt | 1:张三,22
test.txt | 2:李四,23
test.txt | 3:小芳,18
test1.txt | 1:Alice,18
test1.txt | 2:Bob,19
test1.txt | 3:Celina,20
```
* 自定义变量
  `awk -v OFS="| " '{Foo="Bar";print Foo, $1}' test.txt`
```
Bar| 张三
Bar| 李四
Bar| 小芳
```

### 函数
awk提供了很多内置函数处理数据
* `toupper()`字符串转大写
* `tolower()`字符串转小写
* `length()`返回字符串长度
* `substr()`返回子字符串
* `sin()`正弦
* `cos()`余弦
* `sqrt()`平方根
* `rand()`随机数
> 更多函数及其用法可以使用`man awk`查看

### Pattern 模式条件
awk允许指定输出条件，只输出符合条件的行；模式通常有两种类型：
* 数学及逻辑运算符：(`<,<=,==,>,>=,!=,&&,||,|`)
* 正则表达式匹配(`~`:匹配返回`true`；`!~`:不匹配返回`true`),符号不是必须的，不适用表示对整体进行匹配，否则可以对指定列进行匹配，正则表达式必须卸载两个斜杠李(`/正则表达式/`).

语法：输出条件卸载动作的前面；
`awk '[Pattern条件] {动作}' 文件名`

测试数据准备: `test.txt`
```
张三 男 22
李四 男 23
小芳 女 18
小红 女 19
小玉 女 20
小强 男 20
```
* 数学逻辑运算符
    * 查找年龄大于20岁的
      `awk '$NF>20 {print $0}' test.txt`
```
张三 男 22
李四 男 23
```
	* 查找男性
``awk '$2=="男" {print $0}' test.txt``
```
张三 男 22
李四 男 23
小强 男 20
```
	* 打印偶数行
`awk 'NR%2==0' {print NR,$0} test.txt`
```
2 李四 男 23
4 小红 女 19
6 小强 男 20
```
* 打印年龄总和
  `awk '{sum += $3}' END {print "年龄总和:",sum} test.txt`
```
年龄总和: 122
```
* 打印平均年龄
  `awk '{sum += $3}' END {print "平均年龄:",sum/NR} test.txt`
```
年龄总和: 20.3333
```
* 打印最大年龄
  `awk ' max < $3 {max = $3}' END {print "最大年龄:",max} test.txt`
```
最大年龄: 23
```
* 打印最小年龄
  `awk ' min == 0 || min > $3 {min = $3}' END {print "最小年龄:",min} test.txt`
```
最小年龄: 18
```


* 正则匹配
  * 打印第3列以2开头的行
  `awk '$3~/^2/ {print NR, $0}' test.txt`
  ```
  1 张三 男 22
  2 李四 男 23
  5 小玉 女 20
  6 小强 男 20
  ```
  * 打印第三列不以2开头的行
  `awk '$3!~/^2/ {print NR, $0}' test.txt`
  ```
  3 小芳 女 18
  4 小红 女 19
  ```
  * 整行匹配,匹配带2的
  `awk '/2/ {print NR, $0}' test.txt`
  ```
  1 张三 男 22
  2 李四 男 23
  5 小玉 女 20
  6 小强 男 20
  ```
> 如果不加`~`或者`!~`，只能对整行做正则匹配

  * 正则行范围模式
  awk中同时写两个正则，以逗号隔开，表示在满足第一个正则和第二个正则之间的所有行(包括)，都会输出。
  `awk '/李四/,/小玉/ {print NR, $0}' test.txt`
  ```
  2 李四 男 23
  3 小芳 女 18
  4 小红 女 19
  5 小玉 女 20
  ```

### awk脚本
举例：有一个分数表长下面的样子：
```
$ cat score.txt # 即
Marry   2143 78 84 77
Jack    2321 66 78 45
Tom     2122 48 77 71
Mike    2537 87 97 95
Bob     2415 40 57 62
```
编写如下脚本
```
$ cat cal.awk

#!/bin/awk -f
  
# 运行前，定义一些变量，打印一些前置文案  
BEGIN {  
    math = 0  
    english = 0  
    computer = 0  
  
    printf "Name    No.     Math    English     Computer    Total\n"  
    printf "-----------------------------------------------------\n"  
}  
  
# 运行中  
{  
    math += $3  
    english += $4  
    computer += $5  
  
    printf "%-6s %-6s %4d %8d %8d %8d\n", $1, $2, $3, $4, $5, $3+$4+$5  
}  
  
# 运行后  
END {  
    printf "-----------------------------------------------------\n"  
    printf " Total:%10d %8d %8d\n", math, english, computer  
    printf "Average:%10.2f %8.2f %8.2f\n", math/NR, english/NR, computer/NR  
}
```
先给[cal.awk](./cal.awk)执行权限`sudo chmod +x cal.awk`

执行命令：`./cal.awk score.txt`，输出：
```
Name    No.     Math    English     Computer    Total
-----------------------------------------------------
Marry  2143     78       84       77      239
Jack   2321     66       78       45      189
Tom    2122     48       77       71      196
Mike   2537     87       97       95      279
Bob    2415     40       57       62      159
-----------------------------------------------------
 Total:       319      393      350
Average:     63.80    78.60    70.00
```

### 其他花活
* 打印九九乘法表
  `seq 9 | sed 'H;g' | awk -v RS='' '{for(i=1;i<=NF;i++)printf("%dx%d=%d%s", i, NR, i*NR, i==NR?"\n":"\t")}'`




## 参考文章
* [Linux三剑客-比较推荐这个人的博客](https://www.xiebruce.top/1385.html)
* [awk简明教程](https://coolshell.cn/articles/9070.html)
* [awk入门教程](https://www.ruanyifeng.com/blog/2018/11/awk.html)
* [Linux awk命令](https://www.runoob.com/linux/linux-comm-awk.html)