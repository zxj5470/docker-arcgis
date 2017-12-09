
<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->
<!-- code_chunk_output -->

* [中文](#中文)
	* [开始](#开始)
	* [下载镜像](#下载镜像)
	* [第一次初始化,在/home/arcgis处挂载空卷`arcgisdata`](#第一次初始化在homearcgis处挂载空卷arcgisdata)
	* [在容器中：](#在容器中)
	* [最后：运行（挂载刚刚的`arcgisdata`）](#最后运行挂载刚刚的arcgisdata)
	* [使用后台运行……](#使用后台运行)
	* [关闭容器](#关闭容器)

<!-- /code_chunk_output -->

# 中文

如果你非要自己构建
那么arcgis server 10.2 for linux 的下载链接在这里 https://pan.baidu.com/s/1hsL8UqC 
仓库中的`server.ecp`文件（server.ecp到期时间 2024年12月31日）

## 开始 
先设置一下命令行的alias （只是为了方便命令行使用）
```bash
vi .bashrc
```
在最后添加上
```bash
alias docker='sudo docker'
alias dkrm='sudo docker stop $(sudo docker ps -aq)&& sudo docker rm $(sudo docker ps -aq)'

#如果你已经是用的root账户那么只需要这一行代码就行
alias dkrm='docker stop $(docker ps -aq)&& docker rm $(docker ps -aq)'
#刷新一下命令行
source ~/.bashrc
```

## 下载镜像
镜像在阿里云上（毕竟docker官方的站网速带不动）
```bash
docker pull registry.cn-hangzhou.aliyuncs.com/zxj5470/arcgis-server
# 设置创建卷
docker volume create arcgisdata
```

## 第一次初始化,在/home/arcgis处挂载空卷`arcgisdata`
first init run a volume into files 
```
docker run -it -p 6080:6080 -v arcgisdata:/home/arcgis  registry.cn-hangzhou.aliyuncs.com/zxj5470/arcgis-server
```

## 在容器中：
in container:
```bash
[arcgis@87ffcad24be0 /]$ cp -r /arcgis/server /home/arcgis/
[arcgis@87ffcad24be0 /]$ exit
```
复制后退出。
使用dkrm停止（如果你的电脑还有其他容器不能停止那么请自行查找后关闭，这很重要）

## 最后：运行（挂载刚刚的`arcgisdata`）
```bash
docker run -it -p 6080:6080 -v arcgisdata:/arcgis/  registry.cn-hangzhou.aliyuncs.com/zxj5470/arcgis-server
```

## 使用后台运行……
```bash
docker run -id -p 6080:6080 -v arcgisdata:/arcgis/ registry.cn-hangzhou.aliyuncs.com/zxj5470/arcgis-server
```
稍等几秒左右就可以了……（视机器情况而定）
浏览器刷新 
http://localhost:6080/arcgis/manager

此时会返回一个id……取前4位即可
```bash
c20d9db52d8e2333333333333333

docker exec -it c20d /bin/bash

# [arcgis@c20d9db52d8e /]$ cd /arcgis/server
# [arcgis@c20d9db52d8e /]$ ./startserver.sh
# [arcgis@c20d9db52d8e /]$ exit
```

## 关闭容器
```
dkrm
```
