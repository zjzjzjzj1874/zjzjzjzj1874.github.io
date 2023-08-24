
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
```shell
Usage
usage: screencapture [-icMPmwsWxSCUtoa] [files]
  -c         force screen capture to go to the clipboard
  -b         capture Touch Bar - non-interactive modes only
  -C         capture the cursor as well as the screen. only in non-interactive modes
  -d         display errors to the user graphically
  -i         capture screen interactively, by selection or window
               control key - causes screen shot to go to clipboard
               space key   - toggle between mouse selection and
                             window selection modes
               escape key  - cancels interactive screen shot
  -m         only capture the main monitor, undefined if -i is set
  -D<display> screen capture or record from the display specified. -D 1 is main display, -D 2 secondary, etc.
  -o         in window capture mode, do not capture the shadow of the window
  -p         screen capture will use the default settings for capture. The files argument will be ignored
  -M         screen capture output will go to a new Mail message
  -P         screen capture output will open in Preview or QuickTime Player if video
  -I         screen capture output will open in Messages
  -B<bundleid> screen capture output will open in app with bundleid
  -s         only allow mouse selection mode
  -S         in window capture mode, capture the screen not the window
  -J<style>  sets the starting of interfactive capture
               selection       - captures screen in selection mode
               window          - captures screen in window mode
               video           - records screen in selection mode
  -t<format> image format to create, default is png (other options include pdf, jpg, tiff and other formats)
  -T<seconds> take the picture after a delay of <seconds>, default is 5
  -w         only allow window selection mode
  -W         start interaction in window selection mode
  -x         do not play sounds
  -a         do not include windows attached to selected windows
  -r         do not add dpi meta data to image
  -l<windowid> capture this windowsid
  -R<x,y,w,h> capture screen rect
  -v        capture video recording of the screen
  -V<seconds> limits video capture to specified seconds
  -g        captures audio during a video recording using default input.
  -G<id>    captures audio during a video recording using audio id specified.
  -k        show clicks in video recording mode
  -U        Show interactive toolbar in interactive mode
  -u        present UI after screencapture is complete. files passed to command line will be ignored
  files   where to save the screen capture, 1 file per screen
```

* 最常用
```shell
screencapture -ci

# -i 选中一块区域
# -c 选中后保存至剪切板中
```