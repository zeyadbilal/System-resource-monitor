#!/bin/bash



#VARIABLES

CPU_THRESHOLD=1
DISK_THRESHOLD=1
MEMORY_THRESHOLD=1



#FUNCTIONS

#functions of cpu usage
check_cpu_usage(){
        cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print$2 + $4}')
	if (( $(echo "$cpu_usage > $CPU_THRESHOLD" | bc) )); 
	then
		echo "High cpu usage : $cpu_usage %"
	fi		
}

#functions of memory usage
check_mem_usage(){
        mem_usage=$(free | grep "Mem" | awk '{print $3/$2 * 100.0}')
	if (( $(echo "$mem_usage > $MEMORY_THRESHOLD" | bc ) )) ; then
		echo "High memory usage : $mem_usage %"
	fi	
}
#functions of disk usage
check_disk_usage(){
	disk_usage=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
	if [ "$disk_usage" -gt "$DISK_THRESHOLD" ]; then
		echo "High disk usage : $disk_usage %"
	fi	
}



#RUN THE FUNTIOS

check_cpu_usage
check_mem_usage
check_disk_usage


