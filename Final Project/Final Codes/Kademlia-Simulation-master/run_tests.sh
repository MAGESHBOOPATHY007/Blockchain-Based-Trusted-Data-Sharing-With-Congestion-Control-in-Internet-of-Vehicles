#!/bin/sh

if [ $# -lt 6 ]; then
    echo "Usage: ./run_tests.sh <seed> <network size> <trials per experiment> <node disable start bound> <node disable upper bound> <node disable increment>"
    exit
fi

node_increase_n=$4
while [ $node_increase_n -le $5 ]
do
        echo "./RunSimulation.py  $1 $2 $3 $node_increase_n ${node_increase_n}_increase.dat"
	./RunSimulation.py $1 $2 $3 $node_increase_n ${node_increase_n}_increase.dat
        node_increase_n=`expr $node_increase_n + $6`
done
