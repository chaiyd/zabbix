# zabbix

### dingtalk.go 
推送告警至钉钉
```
更改dingtalk中accessToken  secret
编译参数
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build dingtalk.go
```
* 请参考原工程
https://github.com/CatchZeng/dingtalk.git

### zabbix监控MySQL
```
check_mysql_status_per.sh是ZABBIX监控的MySQL所需脚本
zabbix_agentd.conf为监控mysql需要增加的内容
```


### docker-compose
* 仅为zabbix-server，zabbix-agentd请自行安装
```
DB_SERVER_HOST  MySQL ip
DB_SERVER_PORT  MySQL端口
MYSQL_USER      MySQL用户名
MYSQL_PASSWORD  MySQL密码
MYSQL_DATABASE  数据库
ZBX_SERVER_HOST zabbix-server ip，默认不需要更改
ZBX_SERVER_PORT zabbix-server端口，默认不需要更改
```
