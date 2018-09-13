#!/bin/bash
MYSQL_SOCK="/mnt/mysql/mysql.sock"
MYSQL_PWD=zabbix

#2>/dev/null 是为了处理，Warning: Using a password on the command line interface can be insecure.
#网上找了很多资料都说更改mysql配置文件中my.cnf增加用户，考虑到生产环境的原因，个人觉得这样并不安全
case $1 in

Uptime)

		/mnt/mysql/bin/mysqladmin -uzabbix -p${MYSQL_PWD} status 2>/dev/null | awk '{print$2}'
		;;

Com_update)


        /mnt/mysql/bin/mysqladmin -uzabbix -p${MYSQL_PWD} extended-status 2>/dev/null | grep 'Com_update ' 2>/dev/null|awk 'BEGIN{FS="|"}{print $3}'
        ;;

Slow_queries)


        /mnt/mysql/bin/mysqladmin -uzabbix -p${MYSQL_PWD} extended-status 2>/dev/null | grep 'Slow_queries'  | awk 'BEGIN{FS="|"}{print $3}'

        ;;

Com_select)


        /mnt/mysql/bin/mysqladmin -uzabbix -p${MYSQL_PWD} extended-status 2>/dev/null | grep 'Com_select'  | awk 'BEGIN{FS="|"}{print $3}'

        ;;

Com_rollback)


        /mnt/mysql/bin/mysqladmin -uzabbix -p${MYSQL_PWD} extended-status 2>/dev/null | grep 'Com_rollback '  | awk 'BEGIN{FS="|"}{print $3}'

        ;;

Questions)


        /mnt/mysql/bin/mysqladmin -uzabbix -p${MYSQL_PWD} extended-status 2>/dev/null | grep 'Questions'  | awk 'BEGIN{FS="|"}{print $3}'

        ;;

Com_insert)


        /mnt/mysql/bin/mysqladmin -uzabbix -p${MYSQL_PWD} extended-status 2>/dev/null | grep 'Com_insert '  | awk 'BEGIN{FS="|"}{print $3}'

        ;;

Com_delete)


        /mnt/mysql/bin/mysqladmin -uzabbix -p${MYSQL_PWD} extended-status 2>/dev/null | grep 'Com_delete '  | awk 'BEGIN{FS="|"}{print $3}'

        ;;

Com_commit)


        /mnt/mysql/bin/mysqladmin -uzabbix -p${MYSQL_PWD} extended-status 2>/dev/null | grep 'Com_commit'  | awk 'BEGIN{FS="|"}{print $3}'

        ;;

Bytes_sent)


        /mnt/mysql/bin/mysqladmin -uzabbix -p${MYSQL_PWD} extended-status 2>/dev/null | grep 'Bytes_sent'  | awk 'BEGIN{FS="|"}{print $3}'

        ;;

Bytes_received)


        /mnt/mysql/bin/mysqladmin -uzabbix -p${MYSQL_PWD} extended-status 2>/dev/null | grep 'Bytes_received'  | awk 'BEGIN{FS="|"}{print $3}'

        ;;

Com_begin)


        /mnt/mysql/bin/mysqladmin -uzabbix -p${MYSQL_PWD} extended-status 2>/dev/null | grep 'Com_begin'  | awk 'BEGIN{FS="|"}{print $3}'

        ;;

*)
       echo "Please choise one optinon ( Uptime|Com_update|Slow_queries|Com_select|Com_rollback|Questions|Com_insert|Com_delete|Com_commit|Bytes_sent|Bytes_received|Com_begin )"

        ;;

esac
