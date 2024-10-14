# Private Ethereum Network Setup

Welcome to the README for setting up a simple private Ethereum network using Geth! This guide will walk you through the steps of creating a private network on your local machine with two nodes. The nodes will run on the same genesis block and network ID, using the Geth client.

## Getting Started

To get started with your private Ethereum network, follow these steps:

### Step 1: Clone the Repository

Clone this repository to your local machine:

bash
git clone https://github.com/your-username/your-repo.git

Step 2: Set Up Nodes and Accounts
Create two data directories for your nodes:

mkdir node1 node2
Generate account for each node;

geth --datadir node1 account new
geth --datadir node2 account new

Step 3: Prepare Genesis Configuration
Create a genesis.json file in the top-level directory of your project and update it with the provided JSON configuration.

Step 4: Initialize Nodes
Initialize each node with the provided genesis.json:

geth init --datadir node1 genesis.json
geth init --datadir node2 genesis.json

Step 5: Start Nodes
In separate terminal windows, start both nodes with appropriate configurations. Replace the placeholders with actual values:

./geth --datadir node1 --port 30306 --bootnodes enode://... --networkid 123454321 --unlock ACCOUNT_ADDRESS --password node1/password.txt --authrpc.port 8551
./geth --datadir node2 --port 30307 --bootnodes enode://... --networkid 123454321 --unlock ACCOUNT_ADDRESS --password node2/password.txt --authrpc.port 8552

Step 6: Interact with the Network
Attach a JavaScript console to either node using:

geth attach node1/geth.ipc

From the console, you can query network properties, check connected peers, and more.

Contributing
Feel free to contribute to this repository by submitting pull requests. If you encounter any issues or have suggestions, please open an issue.

License
This project is licensed under the MIT License - see the LICENSE file for details.


Remember to replace placeholders like `your-username`, `your-repo`, `enode://...`, `ACCOUNT_ADDRESS`, etc., with actual values from your setup. Make sure to provide accurate instructions and adapt the sample to fit your specific use case.

Feel free to customize this template further based on your needs and the structure of your repository.
