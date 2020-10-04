
# Initialize the control plane nodes:
### These scripts are interactive, you will be prompted with a yes/no question: type '1' for yes and '2' for no.
#
### First copy the script files to the target machine (Master node), then use the following commands to run the scripts.
#
### Use environment variables (with export) for scripts that require configuration, otherwise you will be prompted to enter the values manually at runt time.
#

## 01 - Initialize the first master:
### run kubeadm init on the first master.
```
SCRIPT_PATH="02_initialize_control_plane_nodes/01_initialize_the_first_master.sh"
export LOAD_BALANCER_IP="92.168.10.100"
export K8S_VERSION="1.18.9"
bash   $SCRIPT_PATH
```

## 02 - Create new Master join command (Run on a joined master node):
### Prints a master join command on the terminal:
```
SCRIPT_PATH="02_initialize_control_plane_nodes/02_create_master_join_command.sh"
bash   $SCRIPT_PATH
```