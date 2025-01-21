#! /bin/bash

# Functon to create pet-clinic user 
create_pet-clinic_user(){

    # Check if user already exists
    if id "pet-clinic" &>/dev/null; then
	echo "User 'pet-clinic' already exists."
    else
	# Create the user
	echo "Creating user 'pet-clinic'..."
	sudo useradd -m pet-clinic
	if [ $? -ne 0 ]; then
	    echo "Error: Failed to create user 'pet-clinic'."
	    exit 1
	fi

	# Prompt for password
	while true; do
	    # Set password
	    sudo passwd pet-clinic
	    # Check if no errors
	    if [ $? -eq 0 ]; then
	          echo "User 'pet-clinic' created successfully"
        	  break	
	    fi
	done
    fi
}



# Function to install Java JDK in the new user home directory

install_jdk(){
    
    # Define default variables
    local USER_HOME=$1 # Pass user home directory to the function
    JDK_Version="17"   # Add desired JDK version
    JDK_Build="17.0.12" # Add desired JDK build
    Install_Dir="$USER_HOME/java_${JDK_Version}" # Directory path to install java
    Download_URL="https://download.oracle.com/java/${JDK_Version}/archive/jdk-${JDK_Build}_linux-x64_bin.tar.gz" # Constructing the downlad URL
    
    # Check if installation directory already exist and create it if doesn't exist
    if [ -d "${Install_Dir}" ]; then
	echo "Installation directory already exists."
    else
	echo "Creating installation directory at $Install_Dir"
	mkdir -p "${Install_Dir}"
    fi

    # Check if JDK already installed
    if [ -x "${Install_Dir}/bin/java" ]; then
	echo "JDK already installed"
	exit 0
    fi

    # Download JDK
    echo "Downloading JDK ${JDK_Version} (${JDK_Build})..."
    wget -q --show-progress -O "${Install_Dir}/jdk.tar.gz" "${Download_URL}"
    if [ $? -ne 0 ]; then # Checking for failed download
	echo "Error: Failed to download JDK"
	exit 1
    fi

    # Extracting JDK
    echo "Extracting JDK to ${Install_Dir}..."
    tar -xzf "${Install_Dir}/jdk.tar.gz" -C "${Install_Dir}" --strip-components=1
    if [ $? -ne 0 ]; then
	echo "Failed to extract JDK"
	exit 1
    fi
    rm "${Install_Dir}/jdk.tar.gz"  #Deleting tar file

    # Setting environment variables
    if ! grep -q "JAVA_HOME=${Install_Dir}" "$USER_HOME/.bashrc"; then
	echo "Setting up environment variables..."
	echo "export JAVA_HOME=${Install_Dir}" >> "$USER_HOME/.bashrc"
	echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> "$USER_HOME/.bashrc"
    else
	echo "Environment variables already set"
    fi

    # Change owner to ensure user 'pet-clinic' can access the files
    chown pet-clinic:pet-clinic "${USER_HOME}/.bashrc"

    # Apply environment changes
    echo "Applying environment changes..."
    su - pet-clinic -c "source ${USER_HOME}/.bashrc"

    # Verify installation
    echo "Verifying JDK installation..."
    su - pet-clinic -c "java -version"

    if [ $? -eq 0 ]; then
	echo "JDK successfully installed"
    else
	echo "Error: JDK installation failed"
    fi

}

# Calling the functions to create the user then install JDK
create_pet-clinic_user

install_jdk "/home/pet-clinic"
