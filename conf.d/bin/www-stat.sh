#!/bin/bash
netstat -ant | grep ESTABLISHED | grep -E '\:(80|443)' | awk '{ print $5 }' | cut -f 1 -d : | sort | uniq | wc -l
