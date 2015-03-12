#!/bin/bash
set -e

if [ ! -z "$GRAYLOG_PASSWORD" ]; then
        graylog-ctl set-admin-password $GRAYLOG_PASSWORD
fi
if [ ! -z "$GRAYLOG_TIMEZONE" ]; then
        graylog-ctl set-timezone $GRAYLOG_TIMEZONE
fi
if [ ! -z "$GRAYLOG_SMTP_SERVER" ]; then
        graylog-ctl set-email-config $GRAYLOG_SMTP_SERVER
fi
if [ ! -z "$GRAYLOG_RETENTION" ]; then
        graylog-ctl set-retention $GRAYLOG_RETENTION
fi
if [ ! -z "$GRAYLOG_MASTER" ]; then
        graylog-ctl local-connect && graylog-ctl set-cluster-master $GRAYLOG_MASTER
fi
if [ ! -z "$GRAYLOG_WEB" ]; then
        graylog-ctl reconfigure-as-webinterface
elif [ ! -z "$GRAYLOG_SERVER" ]; then
        graylog-ctl reconfigure-as-backend
else
        graylog-ctl local-connect && graylog-ctl reconfigure
fi