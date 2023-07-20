# 参数定义

[//]: # (## 参数列表)

[//]: # ()
[//]: # (| 参数名     | 类型                           | 描述                 |)

[//]: # (|------------|------------------------------|----------------------|)

[//]: # (| name       | string                       | 用户名               |)

[//]: # (| age        | number                       | 年龄                 |)

[//]: # (| address    | string                       | 住址                 |)

[//]: # (| contact    | [details]&#40;parameter/contact&#41; | 联系方式，展开查看   |)


| 参数名     | 类型               | 描述                 |
|------------|------------------|----------------------|
| name       | string           | 用户名               |
| age        | number           | 年龄                 |
| address    | string           | 住址                 |
| contact    | Object - contact | 联系方式，展开查看   |

<details>
  <summary>contact</summary>

### 联系方式字段

| 字段名      | 类型       | 描述               |
  |------------|------------|--------------------|
| email      | string     | 电子邮箱           |
| phone      | string     | 手机号码           |
| social     | details    | 社交账号，展开查看 |

  <details>
    <summary>社交账号</summary>

#### details字段

| 字段名      | 类型       | 描述            |
|------------|------------|-----------------|
| twitter    | string     | Twitter账号     |
| facebook   | string     | Facebook账号    |
| linkedin   | string     | LinkedIn账号    |

  </details>
</details>