#!/bin/bash

  curl -X POST -H "Accept:application/json" -H "Content-Type:application/json" localhost:8083/connectors/ -d '
  {
   "name": "JDBCSrcConnector-Postgres-ODS-INCR",
   "config": {
  "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
  "connection.url":"jdbc:postgresql://xxxxxxxx.cluster-xxxxxxxx.us-east-1.rds.amazonaws.com:5432/pdt_dev?verifyServerCertificate=false&useSSL=true&requireSSL=true",
  "kafka.auth.mode":"SERVICE_ACCOUNT",
  "kafka.service.account.id": "sa-xxxxxxx",
  "key.converter": "org.apache.kafka.connect.json.JsonConverter",
  "key.converter.schemas.enable": "false",
  "value.converter": "org.apache.kafka.connect.json.JsonConverter",
  "value.converter.schemas.enable": "false",
  "connection.user":"xxxxxxxxx",
  "connection.password":"xxxxxxxxx",
  "connection.attempts":3,
  "catalog.pattern":"pg_catalog",
  "schema.pattern":"prod",
  "mode":"timestamp",
  "timestamp.column.name":"lastmodified",
  "query" : "select d.sfid SalesforceID, d.donorid ,case when pp.paycode in ('\''80054'\'','\''80056'\'') then '\''True'\'' else '\''False'\'' end as PendPayExcept,case when pp.expirationdate>current_timestamp then '\''True'\'' else '\''False'\'' end as expirationdate from prod.pending_payments pp join prod.donor d on pp.pdtdonorid = cast(d.pdtdonorid as int8)",
  "db.timezone":"Asia/Kolkata",
  "validate.non.null":"false",
  "topic.creation.enable":"true",
  "topic.creation.default.replication.factor":"3",
  "topic.creation.default.partitions":"1",
  "topic.prefix":"tp-ods-test-",
  "transforms": "ReplaceField",
  "transforms.ReplaceField.type": "org.apache.kafka.connect.transforms.ReplaceField$Value",
  "transforms.ReplaceField.blacklist": "lastmodified"
  "poll.interval.ms":10000,
  "tasks.max": "1"
   }
