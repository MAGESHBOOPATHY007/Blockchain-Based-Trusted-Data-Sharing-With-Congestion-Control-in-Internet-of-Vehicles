#!/usr/bin/env python2.7
# Author: Christopher Sasarak
# This file contains code to run a simulation of the Kademlia system.

import sys
import node
import csv
from simulation import Simulation

usage = """Usage: ./RunSimulation.py <random seed> <network size> <trials> <disable frequency> [<data output file>]
During each trial, the disable frequency is multiplied by the trial number to get the number of nodes to disable for that trial.
Training will perform half the network size worth of random lookups before testing."""

out_filename = "data.out"
if len(sys.argv) < 5:
    print (usage)
    sys.exit(1)

try:
    network_size = int(sys.argv[2])
    trials = int(sys.argv[3])
    seed = int(sys.argv[1])
    # The rate at which we will disable nodes 
    node_disable_n = int(sys.argv[4])
except ValueError:
    print (usage)
    sys.exit(1)
    
if len(sys.argv) == 6:
    out_filename = sys.argv[5]

print ("Building network")    
sim = Simulation(seed, network_size)
lookups = 1000
# Train the network a bit by doing random lookups
for i in range(int(network_size / 2)):
    if i % 20 == 0:
        sys.stdout.write("\rInitializing network {0:.1f}%".format(i / (network_size / 2.0) * 100))
        sys.stdout.flush()
    sim.perform_node_lookup()
    
sys.stdout.write("\rInitializing network 100% \n\n")
sys.stdout.flush()

for n in sim.nodes:
    n.totalLookupDuration = 0

with open(out_filename, 'wb') as csv_file:
    csv_writer = csv.writer(csv_file, delimiter=' ', quotechar='#', quoting=csv.QUOTE_MINIMAL)
    csv_writer.writerow(["# Trial", "Disabled Nodes Rate {}".format(node_disable_n), "Avg. lookup time"])
    
    for trial in range(trials):
        print ("================================================================================")
        disabled_nodes = trial * node_disable_n
        sim.disable_nodes(node_disable_n)
    
        print ("\nTrial "), trial + 1, " with ", disabled_nodes, " nodes disabled"

        # Perform lookups and then get the average time
        for i in range(lookups):
            sim.perform_node_lookup()

        time_sum = 0
        node_count = 0 # The number of nodes that had lookups performed on them
        for n in sim.nodes:
            if n.totalLookupDuration != 0: 
                time_sum = time_sum + n.totalLookupDuration
                node_count = node_count + 1
                n.totalLookupDuration = 0

        avg_lookup_time = time_sum / node_count / 1000
        print ("Avg. lookup time: {0:.4f} seconds").format(avg_lookup_time)
        csv_writer.writerow([trial + 1, avg_lookup_time])
