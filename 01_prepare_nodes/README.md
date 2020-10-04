
# Prepare Nodes:
### These scripts are interactive, you will be prompted with a yes/no question: type '1' for yes and '2' for no.
#
### First copy the script files to the target machine, then use the following commands to run the scripts.
#
### Use environment variables (with export) for scripts that require configuration, otherwise you will be prompted to enter the values manually at runt time.
#


## 01 - Update the machine:
```
SCRIPT_PATH="01_prepare_nodes/01_update_machine.sh"
bash   $SCRIPT_PATH
```

## 02 - Disable SWAP:
```
SCRIPT_PATH="01_prepare_nodes/02_disable_swap.sh"
bash   $SCRIPT_PATH
```

## 03 - Install Docker:
```
SCRIPT_PATH="01_prepare_nodes/03_install_docker.sh"
export DOCKER_VERSION="5:19.03.13~3-0~ubuntu-focal"
export CONTAINERD_VERSION="1.3.7-1"
bash   $SCRIPT_PATH
```

## 04 - Install Kuberenetes packages:
```
SCRIPT_PATH="01_prepare_nodes/04_install_kube_tools.sh"
export KUBERNETES_VERSION=1.18.9-00
bash   $SCRIPT_PATH
```

## 05 - Change HostName:
```
SCRIPT_PATH="01_prepare_nodes/05_change_host_name.sh"
export NEW_HOST_NAME="Master01"
bash   $SCRIPT_PATH
```
