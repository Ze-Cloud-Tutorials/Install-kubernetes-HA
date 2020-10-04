
# Initialize the control plane nodes:
### These scripts are interactive, you will be prompted with a yes/no question: type '1' for yes and '2' for no.
### First copy the script files to the target machine, then use the following commands to run the scripts.
### Use environment variables (with export) for scripts that require configuration, otherwise you will be prompted to enter the values manually at runt time.

## Create new Worker join command (Run on a master node):
### Prints a worker join command on the terminal:
```
SCRIPT_PATH="03_initialize_workload_nodes/01_create_worker_join_command.sh"
bash   $SCRIPT_PATH
```

## Update the role of a node (Run on a machine with kubectl pointing to the kubernetes cluster):
### Sets the role for worker nodes to 'worker'
```
SCRIPT_PATH="03_initialize_workload_nodes/02_update_worker_node_role.sh"
export ROLE="worker"
export NODE="worker01" # or 'export NODE="worker01 worker02 worker03"'
bash   $SCRIPT_PATH
```