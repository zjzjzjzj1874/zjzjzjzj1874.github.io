
<article-title title="OpenSSL"></article-title>

<article-meta date="2023年8月9日"></article-meta>

---

### 基础操作

#### 查看证书终止日期

```shell
openssl x509 -noout -enddate -in a.crt

# 输出
notAfter=May 25 23:59:59 2024 GMT
```

格式化一下
```shell
openssl x509 -noout -enddate -in a.crt | awk -F'=' '{print $2}' | xargs -I{} date -d "{}" +%Y-%m-%d

# 输出
2023-05-27
```

#### 校验私钥的合法性
```shell
openssl rsa -check -noout -in a.key

# 合法输出
RSA key ok

# 不合法一般输出
unable to load Private Key
```