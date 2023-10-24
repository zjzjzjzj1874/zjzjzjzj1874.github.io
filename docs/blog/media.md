
<article-title title="多媒体资源"></article-title>

<article-meta created="2023年10月24日" updated="2023年10月24日"></article-meta>

---

### 视频资源

#### M3U8格式
M3U8是一种基于HTTP Live Streaming（HLS）来分发流媒体的文件格式。这种格式可以用于分块的多媒体，允许播放器下载并播放一小块媒体文件，然后下载并播放下一块，等等。这样有效地实现了流媒体的实时传输，并可以处理网络速度不一致的问题。

M3U8文件本质上是一个文本文件，包含了一个指向流媒体元数据的指针。这些元数据通常包括分块的视频和音频文件的URL和其他信息。

* 使用FFmpeg转MP4文件
```shell
ffmpeg -i https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8 -c copy x36xhzz.mp4

```
