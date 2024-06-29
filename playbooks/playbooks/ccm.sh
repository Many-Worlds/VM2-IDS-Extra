#!/bin/bash
#This script will create vagrant ansible clusters
#Copyright Phil
CreateCluster () {
	echo "###########################################################"
	echo "#                                                      	  #"
	echo "#    Welcome to the CCM Cluster Creation Menu          	  #"
	echo "#    Choose the ClusterType by pressing the number:    	  #"
	echo "#                                                      	  #"
	echo "#    1. Bronze (1 web and 1 database server)           	  #"
	echo "#                                                      	  #"
	echo "#    2. Silver (2 web and 1 database server)           	  #"
	echo "#                                                      	  #"
	echo "#    3. Gold (3 web and 2 database server and loadbalancer) #"
	echo "#                                                      	  #"
	echo "#    4. Exit the application                           	  #"
	echo "#                                                      	  #"
	echo "###########################################################"

	read choiceCC

	if [ "$choiceCC" -eq 1 ]
	then
	    echo "You have Selected Bronze"
	elif [ "$choiceCC" -eq 2 ]
	then
	    echo "You have Selected Silver"
	elif [ "$choiceCC" -eq 3 ]
	then
	    echo "You have Selected Gold"   
	elif [ "$choiceCC" -eq 4 ]
	then
	    exitfunc
	else
	    echo "Wrong Awnser"
	fi

	read -p "Enter the clustername (in lowercase)that you want to create , followed by [ENTER]:" playbook

	read -p "Do you wana deploy it now press [y]/[n], followed by [ENTER]:" depl

	echo "Creating Cluster"


	if [ "$choiceCC" -eq 1 ]
	then
	    cp -r ~/playbooks/templates/temp-bronze  ~/playbooks/$uname
		cd ~/playbooks/$uname
		mv ~/playbooks/$uname/temp-bronze ~/playbooks/$uname/$playbook
		cd ~/playbooks/$uname/$playbook
		if [ "$depl" = y ]
		then 
			echo "Starting Deplying Cluster"
			vagrant up	
			cd ansible/
			echo "Post Install Check"
			sleep 30
			ansible-playbook install.yml
		fi	
	elif [ "$choiceCC" -eq 2 ]
	then
	    cp -r ~/playbooks/templates/temp-silver  ~/playbooks/$uname
		cd ~/playbooks/$uname
		mv ~/playbooks/$uname/temp-silver ~/playbooks/$uname/$playbook
		cd ~/playbooks/$uname/$playbook
		if [ "$depl" = y ]
		then 
			echo "Starting Deplying Cluster"
			vagrant up	
			cd ansible/
			echo "Post Install Check"
			sleep 30
			ansible-playbook install.yml
		fi	
	elif [ "$choiceCC" -eq 3 ]
	then
	    cp -r ~/playbooks/templates/temp-gold  ~/playbooks/$uname
		cd ~/playbooks/$uname
		mv ~/playbooks/$uname/temp-gold ~/playbooks/$uname/$playbook
		cd ~/playbooks/$uname/$playbook
		if [ "$depl" = y ]
		then 
			echo "Starting Deplying Cluster"
			vagrant up	
			cd ansible/
			echo "Post Install Check"
			sleep 30
			ansible-playbook install.yml
		fi	
	elif [ "$choiceCC" -eq 4 ]
	then
	    exitfunc
	else
	    echo "Wrong Awnser"
	fi

	echo "Cluster Deployed"
}
mainmenu (){
	echo "###########################################################"
	echo "#                                                      	  #"
	echo "#    Welcome $uname, pick a option by pressing the number:  #"
	echo "#                                                      	  #"
	echo "#    1. Create New cluster                             	  #"
	echo "#                                                      	  #"
	echo "#    2. Show Cluster Status                            	  #"
	echo "#                                                      	  #"
	echo "#    3. Check if cluster has network connection        	  #"
	echo "#                                                      	  #"
	echo "#    4. destroy cluster                                	  #"
	echo "#                                                      	  #"
	echo "#    5. Exit the application                           	  #"
	echo "#                                                      	  #"
	echo "###########################################################"
	read choice1

	clearscreen

	if [ "$choice1" -eq 1 ]
	then
	    CreateCluster
	elif [ "$choice1" -eq 2 ]
	then
	    if [ -z "$playbook" ]
		then 
			read -p "Enter the clustername (in lowercase)that you want to test , followed by [ENTER]:" playbook
		fi	
	    cd ~/playbooks/$uname/$playbook
	    vagrant status  
	elif [ "$choice1" -eq 3 ]
	then 
		if [ -z "$playbook" ]
		then 
			read -p "Enter the clustername (in lowercase)that you want to test , followed by [ENTER]:" playbook
		fi
		echo"Testing Cluster"	
	    cd ~/playbooks/$uname/$playbook
	    ansible all -m ping   
	elif [ "$choice1" -eq 4 ]
	then
		if [ -z "$playbook" ]
		then 
			read -p "Enter the clustername (in lowercase)that you want to destroy , followed by [ENTER]:" playbook
		fi	
	    cd ~/playbooks/$uname/$playbook
		read -p "Do you want to also destroy all files  now press [y]/[n], followed by [ENTER]:" destr
		if [ "$destr" = y ]
		then 
			vagrant destroy -f
			echo "Destroying Files"
			cd ~/playbooks/$uname
	    	rm -rf $playbook
	    	echo "Files destroyed"
		else
			vagrant destroy -f
		fi	 
	elif [ "$choice1" -eq 5 ]
	then
	    exitfunc
	else
	    echo "Wrong Awnser"
	fi
}

exitfunc()
{
    echo "Stopping the Menu, Please come again"
    exit 1
}

clearscreen()
{
    clearing=`clear`
    echo $clearing
}

# Start
cat scriptFiles/splash.txt


read -p "Press Enter to continue" splashin

read -p "What is your name (in lowercase):" uname



if [ -d "$uname" ]; then
	echo "Welcome back $uname"
	cd $uname
	var_path=`pwd`

elif [ ! -d "$uname" ]; then
	echo "I see that you are new, Creating Directory"
	mkdir $uname
	echo "Welcome $uname"
	cd $uname
	var_path=`pwd`
fi

clearscreen

mainmenu

mainmenu


