
### config-context(主要用于对多集群的访问)

- context上下文
    - 列出当前配置文件中定义的所有上下文 `kubectl config get-contexts`
    - 查看当前所选上下文 `kubectl config current-context`
    - 切换当前上下文为minikube `kubectl config use-context minikube`
    - 切换默认命名空间到kube-public `kubectl config set-context --current --namespace=kube-public`
    - 查看当前k8s配置文件 `kubectl config view`
    - 简化查看配置文件 `kubectl config view --minify`
    - 安装kubectx,让命令更简化
      - `kubectx` 列出所有可用上下文
      - `kubectx <context-name>` 切换到特定上下文
      - `kubens` 列出当前上下文中所有命名空间
      - `kubens <namespace>` 切换到某个ns

### 使用k8s启动pod

- 单独启动pod
    - 启动命令: `kubectl run nginx --image=nginx`
    - 查看pod `kubectl get pod`
    - 尝试不启动运行: `kubectl run nginx --image=nginx --dry-run=client`
    - 尝试不启动运行并输出部署文件 `kubectl run nginx --image=nginx --dry-run=client -o yaml`
    - 删除pod `kubectl delete pod nginx`
- 使用deployment启动
    - 启动命令: `kubectl create deployment nginx --image=nginx --replicas=2`
    - 模拟启动: `kubectl create deployment nginx --image=nginx --replicas=2 --dry-run=client`
    - 模拟启动并输出部署文件: `kubectl create deployment nginx --image=nginx --replicas=2 --dry-run=client -o yaml`

### 镜像升级

- 以nginx为例,修改镜像image: `kubectl set image deployment/nginx nginx=nginx:1.19`
- 更新镜像并记录操作过程(方便回滚): `kubectl set image deployment/nginx nginx=nginx:1.19 --record`

### K8S常见资源类型

- `nodes`: 节点,即k8s的工作节点
- `namespaces`: 命名空间,主要用于隔离服务资源
- `deployment`: 无状态部署清单,修改部署清单,可能会对正在运行的pod有影响
- `replicaset`: 复制集,也是无状态的
- `services`: 服务,deployment启动服务之后,对外提供服务即是一个service
- [daemonset](https://kubernetes.io/zh-cn/docs/concepts/workloads/controllers/daemonset/): 守护程序集,包括集群/日志收集/监控守护进程,注意:
  删除daemonset会删除它创建的所有pod
- `statefulset`: 有状态集,包括mysql和redis等,需要持久化存储的,他们删除或创建都是有序的,区别于deployment创建的无状态集
- `pods`: k8s的最小调度单位,同一个pod中的容器将共享存储和网络,这些容器有亲和性,所以会被调度到同一个pod中
- [ingress](https://jimmysong.io/kubernetes-handbook/concepts/ingress.html): 外部访问k8s集群内部服务的入口,即进入集群的流量一般由ingress分发;
  K8S支持并维护GCE和Nginx两种,其他常见的Ingress Controller包括:Traefik,F5,Kong,Istio
- 其他的:`configmaps/endpoints/events/secrets/serviceaccounts/cronjobs/jobs/roles...`

### delete操作

- mostly use
    - delete deployment `kubectl delete deployment {deployment-name}`
    - delete ns `kubectl delete namespace {namespace-name}` equal `kubectl delete ns {namespaec-name}`
    - delete pod `kubectl delete pod(s) {pod-name}`
    - note:部署如果是3个pod,那么delete一个之后,可能会很快起一个,因为deployment决定的
      可以使用`kubectl edit deployment {deployment-name}`来改变副本数量
- delete other resource: `cronjob/configmap/ingress/job/node/pvc/svc/sa/secret/statefulset`

### describe操作

- mostly use
    - node `kubectl describe node`,包括系统信息,命名空间等...
    - ingress `kubectl describe ingress`
    - ns `kubectl describe namespace`
    - pods `kubectl describe pods (+ {pod-name})`
    - replicaset(副本集) `kubectl describe replicaset`
    - service `kubectl describe svc`
    - statefulset(有状态集) `kubectl describe statefulset`
- describe other resource `daemonset/configmap/pvc/secret/sa(=serviceAccount)...`

### edit操作

- mostly use
    - node `kubectl edit node`
    - ns `kubectl edit namespace {namespace-name}`
    - deployment `kubectl edit deployment {deployment-name}`,常用于临时修改镜像,副本数量等
    - pods `kubectl edit pods {pods-name}`
    - statefulset(有状态集) `kubectl edit statefulset {name}`
    - replicaset(副本集) `kubectl edit replicaset {name}`
    - edit others `cronjob/configmap/daemonset/ingress/job/pvc/svc...`

### get操作

- get all
    - 当前ns下获取所有资源:`kubectl get all` => 包括(pods/deployment/service/replicaset/statefulset..)
    - 获取所有命名空间下所有资源:`kubectl get all --all-namespaces` => 包括(
      pods/deployment/service/replicaset/statefulset..)
    - note:`--all-namespaces == -A` == `kubectl get all -A`,下同
- configmap
    - in current ns:`kubectl get configmaps`
    - in all ns:`kubectl get configmaps -A`
- deployment
    - in current ns:`kubectl get deployment`
    - in all ns:`kubectl get deployment -A`
- pods
    - in current ns:`kubectl get pods`
    - in all ns:`kubectl get pods -A (-o wide)`
    - watching pod status:`kubectl get pods -w`
- others
    - `cronjob/daemonset/ingress/job/nodes/namespaces/pvc/svc/replicaset/statefulset/secret`
- `-o`:more info
    - `wide`: 输出更多信息
    - `json`: 以json格式输出
    - `yaml`: 以yaml格式输出

### exec操作

- 进入pod `kubectl exec -it {pod-name} bash`
- 不进入pods打印环境变量 `kubectl exec {pod-name} env`
- 不进入pod查看根目录文件结构 `kubectl exec {pod-name} ls /`
- 查看进程 `kubectl exec {pod-name} ps aux`
- 查看进程内容 `kubectl exec {pod-name} cat /proc/1/mounts`

### 命名空间-namespace

- 创建命名空间 `kubectl create namespace kms-v2`
- 查看命名空间 `kubectl get nemaspace`
- 设置名字空间偏好 `kubectl config set-context --current --namespace=<名字空间名称>`
- 验证 `kubectl config view | grep namespace:`
- 查看位于名字空间中的资源 `kubectl api-resources --namespaced=true`
- 查看不在名字空间中的资源 `kubectl api-resources --namespaced=false`

### 部署清单 deployment

- 查看部署清单 `kubectl get deploy (-o wide)`
- 查看部署清单描述信息 `kubectl describe deployment  nginx-deployment`
- 部署清单 `kubectl apply -f quota-pod.yaml --namespace=kms-v2`
- 删除部署 `kubectl delete deployment {deployment-name}`

### pod(豆荚)

- 查看所有命名空间下容器 `kubectl get pod -A`
- 查看对于命名空间下容器 `kubectl get pod (-n kms-v2)`
- 查看容器描述 `kubectl describe pod {pod-name}`
- 查看日志 `kubectl logs -f {pod-name}`
- 进入容器 `kubectl exec -it {pod-name} bash` or `kubectl exec -it {pod-name} sh`
- 在容器中运行单个命令
    - 查看环境变量: `kubectl exec {pod-name} env` => 注:docker同理
    - 查看进程 `kubectl exec {pod-name} ps aux`
    - 查看目录 `kubectl exec {pod-name} ls /`
    - 查看进程内容 `kubectl exec {pod-name} cat /proc/1/mounts`

### 其他常用操作

#### 端口转发port-forward

- 容器端口转发 `kubectl port-forward pods/{pod-name} 8080:80`
- 服务端口转发 `kubectl port-forward service/{service-name} 8080:80`

#### pods资源查看

- 查看CPU内存消耗 `kubectl top pod`

#### 日志查看

- 查看单个容器日志:`kubectl logs (-f) {pods-name}`
- 查看所有标签`app=nginx-demo`的容器日志:`kubectl logs -l app=nginx-demo --all-containers=true`
- 查看所有标签`app=nginx-demo`的容器日志:`kubectl logs -l app=nginx-demo --all-containers=true`
- 查看容器一个小时前:`kubectl logs --since=1h {pod-name}`

#### scale主要(针对deployment和statefulset)

- 将部署集deployment-nginx副本设置为3:`kubectl scale --replicas=3 deployment/deployment-nginx`
- 如果部署集deployment-nginx副本为1,那么将其副本设置为2:`kubectl scale --current-replicas=1 --replicas=2 deployment/deployment-nginx`
- statefulset同理

#### configmap - [配置中心](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/configure-pod-configmap/#use-configmap-defined-environment-variables-in-pod-commands)

- 字面量创建配置 `kubectl create configmap special-config --from-literal=special.how=very`
- 文件创建配置 `kubectl create configmap special-config --from-file=configmap/game.yaml`
- 创建配置 `kubectl create configmap special-config --from-literal=special.how=very`
- 查看配置列表 `kubectl get configmap`
- 以yaml格式查看某个配置详情 `kubectl get configmap special-config -o yaml`

我们采用配置文件挂载到configmap中,启动再指定configmap的[方案](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/configure-pod-configmap/#add-configmap-data-to-a-specific-path-in-the-volume)

- 如果k8s的yaml不支持环境变量设置,那么采用shell中预先生成的方式
- 不同环境先将配置cp一份为k8s.yaml;
- 然后先删除原来的configmap,再创建新的configmap
- 最后重新启动即可

### 推荐集群操作工具:

- [k9s](https://github.com/derailed/k9s):解放命令行操作神器
- [helm](https://helm.sh/docs/):K8S包管理工具,CNCF毕业项目
    - 安装: `brew install helm`
    - 初始化Helm Chart存储库:`helm repo add bitnami https://charts.bitnami.com/bitnami`
    - 查找bitnami库中的可用图表:`helm search repo bitnami`
    - 更新helm的repo: `helm repo update`
    - helm启动etcd:`helm install bitnami/etcd --generate-name`
    - 查看helm安装的服务: `helm list`
    - 卸载helm安装的服务: `helm uninstall etcd-1612624192`
    - 更多请查看官方文档

### K8S参考资料

- [how to install minikube](https://jimmysong.io/kubernetes-handbook/develop/minikube.html)
- [Minikube Tutorial](https://kubernetes.io/zh-cn/docs/tutorials/hello-minikube/)
- [k8s基础教程-云原生](https://lib.jimmysong.io/kubernetes-handbook/)
- [k8s命令行手册](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-strong-getting-started-strong-)
- [k8s APIs和CLIs的设计文档](http://kubernetes.kansea.com/docs/user-guide/kubectl/kubectl/)
- [k8s资源类型](https://kubernetes.io/zh-cn/docs/reference/kubectl/#%E8%B5%84%E6%BA%90%E7%B1%BB%E5%9E%8B)
- [k8s工作负载资源](https://kubernetes.io/docs/concepts/workloads/controllers/)
- [k8s部署mysql](https://kubernetes.io/zh-cn/docs/tasks/run-application/run-replicated-stateful-application/#deploy-mysql)
- [helm Docs](https://helm.sh/docs/)
- [helm Tutorial](https://helm.sh/docs/intro/)