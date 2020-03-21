#!/usr/bin/env bash

# configure influx db

influx
GRANT ALL ON "internetspeed" to "speedmonitor"
quit