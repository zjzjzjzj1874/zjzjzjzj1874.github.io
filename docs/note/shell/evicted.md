<article-title title="删除被驱逐的Pod"></article-title>

<article-meta date="2023年7月24日"></article-meta>

--- 

### 删除所有NS下被驱逐的Pod

```shell
#!/bin/bash


# 删除被驱逐的pod 使用规则 ./del_evicted.sh => 删除所有命名空间下被驱逐的pod

kubectl get pods -A | grep "Evi" | awk '{print $1,$2}' | while IFS= read -r each; do
    namespace=$(echo "$each" | awk '{print $1}')
    pod_name=$(echo "$each" | awk '{print $2}')

    echo "delete pod "$pod_name" -n "$namespace""
    kubectl delete pod "$pod_name" -n "$namespace"
done

echo "删除完成"
```

#### 直接调用
```shell
bash del_evicted.sh
```

#### cron调用
```shell
crontab -e # 编辑Linux中的定时任务 将以下写入文件中,退出,下一个整点即可生效

# 每小时执行，删除被驱逐的pod
0 * * * * /home/ubuntu/scripts/del_evicted_cron.sh > /dev/null 2>&1
```


### 根据命令空间删除被驱逐Pod
```shell
#!/bin/bash

# 删除被驱逐的pod 使用规则 ./del_evicted_by_ns.sh dev => 删除dev空间下被驱逐的pod

ns=$1

if [ -z "${ns}" ]; then
  echo "请传入命名空间"
  exit 1
fi

for each in $(kubectl get pods -n "${ns}" | grep Evicted | awk '{print $1}');

do
	kubectl delete pod "${each}" -n "${ns}";
done

echo "完成删除"
```

#### 直接调用
```shell
bash del_evicted_by_ns.sh default
```

