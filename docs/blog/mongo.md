
<article-title title="MongoDB使用小祭巧"></article-title>

<article-meta date="2023年8月01日"></article-meta>

---

### 基础操作

#### 连接客户端
使用user和pwd登陆客户端,并使用admin认证
```sql
mongo 127.0.0.1:27017 -u user -p pwd --authenticationDatabase admin
```
#### 登陆客户端
登陆
```sql
mongo 127.0.0.1:27017
```
指定admin
```sql
use admin
```
认证
```sql
db.auth("admin":"123456")
```
#### 创建用户
创建用户并指定角色
```sql
db.createUser({user:"admin",pwd:"123456",roles:["root"]})
```

#### 数据库基本操作
查看数据库
```sql
show dbs
```
切换数据库
```sql
use databasesA
```
查询表
```sql
show tables/collections;
```
查询TableA
```sql
db.TableA.find()
```

#### 查询字段是否存在
查询TableA的field_a字段不存在的记录
```sql
db.TableA.find(field_a:{$exists:false}})
```

#### 更新表记录
查询更新TableA中,id=ObjectId("1797501595148103763")这条记录的name和age字段
```sql
db.TableA.updateOne(
    { _id: ObjectId("1797501595148103763") },
    { $set: { name: "hello" ,"age": 18} }
)
```
如果需要更新多条记录,使用updateMany
```sql
db.TableA.updateMany(
    { _id: ObjectId("1797501595148103763") },
    { $set: { name: "hello" ,"age": 18} }
)
```

### 索引操作

#### 创建单个索引
后台为Table_Name的field_a创建一个倒序索引
```sql
db.Table_Name.createIndex({"filed_a":-1},{background:1})
```

#### 创建联合索引
后台为Table_Name的field_a创建一个field_a和created_time的联合倒序索引
```sql
db.Table_Name.createIndex({"filed_a":-1,created_time:-1},{background:1})
```

#### 查看索引
后台为Table_Name的field_a创建一个field_a和created_time的联合倒序索引
```sql
db.Table_Name.getIndexes()
```