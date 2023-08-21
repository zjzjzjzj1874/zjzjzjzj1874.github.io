
<article-title title="Linux常用命令"></article-title>

<article-meta date="2023年8月10日"></article-meta>

---

### 基础命令

#### open
MacOS 下面打开文件，文件夹和应用的命令，类似与 Windows 中的 start

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

* 使用默认浏览器打开 url
```shell
open https://www.baidu.com
```

* 使用指定程序打开文件
```shell
open -a "TextEdit" file.txt
```

* 打开 Finder 窗口
```shell
open .
```

* MacOS 中打开 Chrome 浏览器网页
    ```shell
    open -a "Google Chrome" 'https://www.baidu.com'
    ```
    当然，如果您再配合 alias 使用，效果更佳，如：
    ```shell
    echo "alias open_baidu=\"open -a 'Google Chrome' 'https://www.baidu.com'\"" >> ~/.zshrc
    
    source ~/.zshrc
    
    open_baidu 
    ```
    您就会发现 Google 浏览器的百度页面为您打开了.
* Goland 项目打开
  ```shell
  open -a "GoLand" /path/to/your/project
  ```
  配合 alias 使用，如：
  ```shell
  echo "alias op_shell=\"open -a 'Goland' ~/GolandProjects/shell\"" >> ~/.zshrc
      
  source ~/.zshrc
  
  op_shell 
  ```
  
#### say

MacOS 中，将文字转换成语音并播放出来，查看具体使用语法可以使用`man say`查看。

* 转换普通字符串
```shell
say "Hello World，你好中国，我爱你亲爱的中国."
```
* 转换文件中的字符串`-f`
```shell
say -f hello.txt
```
* 转换的内容保存为音频`-o`，支持 AIFF， caff， m4af， WAVE
```shell
say "Hello World，你好中国，我爱你亲爱的中国。" -o con.aiff
```
* 示例 Examples
```shell
EXAMPLES
          say Hello， World
          say -v Alex -o hi -f hello_world.txt
          say --interactive=/green spending each day the color of the leaves
          say -o hi.aac 'Hello， [[slnc 200]] World'
          say -o hi.m4a --data-format=alac Hello， World.
          say -o hi.caf --data-format=LEF32@8000 Hello， World

          say -v '?'
          say --file-format=?
          say --file-format=caff --data-format=?
          say -o hi.m4a --bit-rate=?
```

#### afplay
该命令用于播放音频文件，`man afplay`或`afplay -h`查看详情

* 播放 mp3 文件
```shell
afplay music.mp3
```

* 查看详情
```shell
afplay -h

    Audio File Play
    Version: 2.0
    Copyright 2003-2013， Apple Inc. All Rights Reserved.
    Specify -h (-help) for command options

  Usage:
  afplay [option...] audio_file
  Options: (may appear before or after arguments)
    {-v | --volume} VOLUME
      set the volume for playback of the file
    {-h | --help}
      print help
    { --leaks}
      run leaks analysis
    {-t | --time} TIME
      play for TIME seconds
    {-r | --rate} RATE
      play at playback rate
    {-q | --rQuality} QUALITY
      set the quality used for rate-scaled playback (default is 0 - low quality， 1 - high quality)
    {-d | --debug}
      debug print output
```

#### screencapture
截取图片存放到文件或者粘贴板中，或者`command + shift + 5`也可以调出来，系统自带的截图录屏
