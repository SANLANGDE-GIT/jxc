#!/usr/bin/env bash
# 定义应用组名
group_name='jxc'
# 定义应用名称
app_name='jxc-deploy'
# 定义应用版本
app_version='1.0-SNAPSHOT'
# 定义应用环境
profile_active='prod'
echo '----copy jar----'
docker stop ${app_name}
echo '----stop container----'
docker rm ${app_name}
echo '----rm container----'
docker rmi "jxc/jxc-deploy:1.0-SNAPSHOT"
echo '----rm image----'
# 打包编译docker镜像
docker build -t jxc/jxc-deploy:1.0-SNAPSHOT .
echo '----build image----'
docker run -p 8180:8180 --name jxc-deploy \
-e 'spring.profiles.active'="prod" \
-e TZ="Asia/Shanghai" \
-v /etc/localtime:/etc/localtime \
-v /mydata/app/jxc-deploy/logs:/var/logs \
-d jxc/jxc-deploy:1.0-SNAPSHOT
echo '----start container----'