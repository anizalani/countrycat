#!/bin/bash
while true
do
    clear
    docker service ls --format "table {{.Name}}\t{{.Mode}}\t{{.Replicas}}\t{{.Ports}}"
    sleep 5
done
