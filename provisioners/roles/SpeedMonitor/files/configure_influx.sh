#!/usr/bin/env bash

# configure influx db

influx
CREATE DATABASE internetspeed
CREATE USER "speedmonitor" WITH PASSWORD 'pimylifeup'
GRANT ALL ON "internetspeed" to "speedmonitor"
quit