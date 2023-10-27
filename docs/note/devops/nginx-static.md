<article-title title="Nginx代理静态资源"></article-title>

<article-meta created="2023年10月26日" updated="2023年10月26日"></article-meta>

--- 

### 配置Nginx

#### 添加Nginx配置
假设您将静态资源存放在`/var/www/static`目录中, 然后在`/etc/nginx/site-available/`目录中创建一个新的Nginx配置文件,比如叫:n_static.conf:
```shell
sudo vim /etc/nginx/site-available/n_static.conf
```
然后将下面配置添加到文件中:
```shell
server {
    listen 80;
    listen [::]:80;

    server_name server-name.com;

    location / {
        autoindex on;
        autoindex_exact_size off;
        autoindex_localtime on;
        root /var/www/videos;
    }
}
```
注意，你需要将上述配置中的`server-name.com`替换为你的服务域名或者IP。

#### 检验配置
* 检查语法问题
```shell
sudo nginx -t
```
如果没有问题会显示:
```shell
nginx: configuration file /etc/nginx/nginx.conf test is successful
```
* 重启Nginx
```shell
sudo nginx -s reload
```


### 本地配置

#### 配置hosts
* MacOS配置
打开`/etc/hosts`然后将对应的IP和域名绑定:比如`server-name.com`对应的IP为:`122.122.122.10`:
```shell
...
122.122.122.10 server-name.com
...
```
* Windows配置
windows配置在`C:\Windows\System32\drivers\etc\hosts`中:
```shell
...
122.122.122.10 server-name.com
...
```

#### 资源访问

加入服务器中有一个资源叫`test.mp4`;
那么在本地访问地址为:`http://server-name.com/test.mp4`