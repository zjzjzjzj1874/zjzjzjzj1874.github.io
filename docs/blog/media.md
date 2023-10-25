
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

* m3u8文件分析
```shell
cat x36hzz.m3u8

---- result ----
#EXTM3U
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2149280,CODECS="mp4a.40.2,avc1.64001f",RESOLUTION=1280x720,NAME="720"
url_0/193039199_mp4_h264_aac_hd_7.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=246440,CODECS="mp4a.40.5,avc1.42000d",RESOLUTION=320x184,NAME="240"
url_2/193039199_mp4_h264_aac_ld_7.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=460560,CODECS="mp4a.40.5,avc1.420016",RESOLUTION=512x288,NAME="380"
url_4/193039199_mp4_h264_aac_7.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=836280,CODECS="mp4a.40.2,avc1.64001f",RESOLUTION=848x480,NAME="480"
url_6/193039199_mp4_h264_aac_hq_7.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=6221600,CODECS="mp4a.40.2,avc1.640028",RESOLUTION=1920x1080,NAME="1080"
url_8/193039199_mp4_h264_aac_fhd_7.m3u8
```
从文件内容来看,文件中指向资源地址的url是相对路径,所以如果仅凭m3u8的文件,无法将视频资源完整下载出来.不过当m3u8文件指向资源的url是绝对路径是,可以正常的下载.
> 所以,M3U8n格式的在线文件链接一般可以正常处理,但是离线文件一般不确定能不能处理,因为无法确定资源是否可以访问.