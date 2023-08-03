
<article-title title="Mysql使用小祭巧"></article-title>

<article-meta date="2023年8月03日"></article-meta>

---  

### 基础操作

#### 连接MySQL客户端
`mysql -h {host} -P {port}/ --port {port} -u {user} -p`
示例:
```sql
mysql -h 127.0.0.1 -P 3306 -u root -p 
```

#### 数据库基础操作
查看数据库
```mysql
show databases;
```
切换数据库
```mysql
use db_test;
```
查看表
```mysql
show tables;
```
查看表结构
```mysql
desc t_test;
```

### DDL&&DML
DDL（Data Definition Language）和DML（Data Manipulation Language）是两种不同类型的SQL语言，用于对数据库进行不同类型的操作。

#### DDL
DDL（数据定义语言）用于定义数据库的结构，包括创建、修改和删除数据库、表、索引等数据库对象。
常见的DDL命令包括：

* CREATE DATABASE：创建新数据库。
  创建数据库db_test并指定编码格式
```mysql
CREATE DATABASE db_test DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```
* DROP DATABASE：删除数据库。
  删除数据库db_test
```mysql
DROP DATABASE db_test;
```
* CREATE TABLE：创建新表。
  新建t_test表
```mysql
DROP TABLE IF EXISTS `t_test`;
CREATE TABLE `t_test` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL COMMENT '姓名',
  `age` int NOT NULL COMMENT '年龄',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_name` (`name`) COMMENT '''名称唯一索引''',
  KEY `I_created_at` (`created_at`) COMMENT '创建时间索引',
  KEY `I_name_created_at` (`name`,`created_at`) USING BTREE COMMENT '''名称,创建时间'''
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```
* ALTER TABLE：修改现有表的结构。
  修改表结构就有很多操作,包括新增删除列,修改列类型等

```mysql
-- 新增字段
ALTER TABLE t_test ADD COLUMN email VARCHAR(100) COMMENT '邮箱';
-- 修改列类型
ALTER TABLE t_test MODIFY COLUMN name varchar(100);
-- 删除列
ALTER TABLE t_test DROP COLUMN email;
```

* DROP TABLE：删除表。
  删除表
```mysql
DROP TABLE t_test;
```

* CREATE INDEX：创建索引。
* DROP INDEX：删除索引。

#### DML
DML（数据操作语言）用于对数据库中的数据进行操作，包括插入、更新和删除数据。
常见的DML命令包括：
* SELECT：从数据库中查询数据。
```mysql
SELECT * FROM t_test;
```
* INSERT INTO：向数据库表中插入新数据。
```mysql
INSERT INTO t_test (id, name, age) VALUES (1, 'John Doe', 30);
```
* UPDATE：更新数据库表中的数据。
```mysql
UPDATE t_test SET age = 35 WHERE name = 'John Doe';
```
* DELETE FROM：从数据库表中删除数据
```mysql
DELETE FROM t_test WHERE age > 40;
```

#### 其他
对比DROP,TRUNCATE和DELETE

* DROP:DDL,可以删除database,table和view
* TRUNCATE:DDL
* DELETE:DML


### 高级语法

#### 查看慢查询数量
```mysql
show global status like '%Slow_queries%';
```