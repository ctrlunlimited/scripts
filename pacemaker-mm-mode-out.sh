#!/bin/bash

# Function to put server out of maintenance mode- os is Suse
put_in_maintenance() {
  SERVER=$1
  echo "Putting $SERVER in maintenance mode..."
  
  # Add logic specific to your system. For example, for Pacemaker clusters, you might use:
  # crm node standby $SERVER
  
  # Example for SSH and running a maintenance command on the server:
  ssh root@$SERVER "systemctl stop critical_service"  # Replace with the service to be stopped
  
  # Assuming Pacemaker is used:
  #ssh root@$SERVER "crm node standby $SERVER"

  # assuming no alias is defined for crm node standby the below can be used instead
  ssh root@$SERVER "/usr/sbin/crm_attribute --type crm_config --name maintenance-mode --update false $SERVER"
  
  # Log output
  echo "$SERVER is now in maintenance mode."
}

# Servers to put in maintenance mode
SERVERS=("serverA" "serverB" "serverC")

# Loop through servers and put each in maintenance mode
for SERVER in "${SERVERS[@]}"; do
  put_in_maintenance "$SERVER"
done

echo "All servers are now in maintenance mode."