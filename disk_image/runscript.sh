#!/bin/sh

cd /home/gem5/spec2017
source shrc
m5 readfile > workloads
echo "Done reading workloads"
if [ -s workloads ]; then
    # if the file is not empty, run spec with the parameters
    echo "Workload detected"
    echo "Reset stats"
    free
    m5 exit
    echo "checkpoint 1"

    # run the commands
    echo "checkpoint 2"
    read -r workload size m5filespath < workloads
    echo "checkpoint 3"
    runcpu --size $size --iterations 1 --config myconfig.x86.cfg --noreportable --nobuild $workload
    echo "checkpoint 4"
    m5 exit
    echo "checkpoint 5"
    
    # copy the SPEC result files to host
    echo "checkpoint 6"
    for filepath in /home/gem5/spec2017/result/*; do
        filename=$(basename $filepath)
        echo "checkpoint 7"
        m5 writefile $filepath $m5filespath/$filename
    done
    echo "checkpoint 8"
    m5 exit
    echo "checkpoint 9"
else
    echo "Couldn't find any workload"
    m5 exit
    m5 exit
    m5 exit
fi
# otherwise, drop to the terminal
