arcgis

you need sudo or make alias like me
```bash
vi .bashrc
```
建议root用户酌情添加dkrm

关闭并删除所有正在运行的容器
```bash
alias docker='sudo docker'
alias dkrm='sudo docker stop $(sudo docker ps -aq)&& sudo docker rm $(sudo docker ps -aq)'
```

下载镜像

```bash
docker pull registry.cn-hangzhou.aliyuncs.com/zxj5470/arcgis-server
# 设置创建卷
docker volume create arcgisdata
```

第一次初始化,在/home/arcgis处挂载空卷`arcgisdata`
first init run a volume into files 
```
docker run -it -p 6080:6080 -v arcgisdata:/home/arcgis  registry.cn-hangzhou.aliyuncs.com/zxj5470/arcgis-server
```

在容器中：
in container:
```bash
[arcgis@87ffcad24be0 /]$ cp -r /arcgis/server /home/arcgis/
[arcgis@87ffcad24be0 /]$ exit
```
复制后退出。
使用dkrm停止（如果你的电脑还有其他容器不能停止那么请自行查找）

最后运行……
```bash
docker run -it -p 6080:6080 -v arcgisdata:/arcgis/  registry.cn-hangzhou.aliyuncs.com/zxj5470/arcgis-server
```

或者使用后台运行……
```bash
docker run -id -p 6080:6080 -v arcgisdata:/arcgis/ registry.cn-hangzhou.aliyuncs.com/zxj5470/arcgis-server
```
稍等五秒左右就可以了……
浏览器刷新 localhost:6080/arcgis/manager

此时会返回一个id……取前4位即可
```bash
c20d9db52d8efc4e461e37636caff340e22dfd3d8a08604773a717c8564bc039
docker exec -it c20d9 /bin/bash

[arcgis@c20d9db52d8e /]$ cd /arcgis/server
[arcgis@c20d9db52d8e /]$ ./startserver.sh
[arcgis@c20d9db52d8e /]$ exit
```

关闭容器
`dkrm`
