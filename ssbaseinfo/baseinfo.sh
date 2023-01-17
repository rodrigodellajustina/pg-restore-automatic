#!/bin/bash
cd /
cd /mnt/disco4tb/script/ssbaseinfo/venv-ssbaseinfo/bin
sleep 3
source activate
sleep 3
cd /
nohup python3 /mnt/disco4tb/script/ssbaseinfo/baseinfo.py 8745 &
sleep 3
nohup python3 /mnt/disco4tb/script/ssbaseinfo/baseinfo.py 8794 &
