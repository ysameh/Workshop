#!/bin/bash


# Function to create the pet-clinic user
create_pet_clinic_user() {
    # Check if user already exists
    if id "pet-clinic" &>/dev/null; then
        echo "User 'pet-clinic' already exists."
    else
        # Create the user
        echo "Creating user 'pet-clinic'..."
        sudo useradd -m -s /bin/bash pet-clinic
        if [ $? -ne 0 ]; then
            echo "Error: Failed to create user 'pet-clinic'."
            exit 1
        fi

        # Prompt for password
        while true; do
            echo "Please set a password for the 'pet-clinic' user:"
            sudo passwd pet-clinic
            if [ $? -eq 0 ]; then
                echo "User 'pet-clinic' created successfully."
                break
            fi
        done
    fi
}

# Function to install Java JDK as the new user
install_jdk_as_pet_clinic() {

    # Defining default variables
    
    JDK_VERSION="17"       # Desired JDK version
    JDK_BUILD="17.0.12"    # Desired JDK build
    INSTALL_DIR="/home/pet-clinic/java_${JDK_VERSION}"
    DOWNLOAD_URL="https://download.oracle.com/java/${JDK_VERSION}/archive/jdk-${JDK_BUILD}_linux-x64_bin.tar.gz"

    # Switch to the pet-clinic user

    echo "Switching to 'pet-clinic' user..."
    echo "Please enter your password"
    su - pet-clinic -c "
        # Create installation directory if it doesn't exist
        if [ ! -d \"$INSTALL_DIR\" ]; then
            echo 'Creating installation directory at $INSTALL_DIR...'
            mkdir -p \"$INSTALL_DIR\"
        fi

        # Check if JDK is already installed
        if [ -x \"$INSTALL_DIR/bin/java\" ]; then
            echo 'JDK is already installed.'
            exit 0
        fi

        # Download the JDK
        echo 'Downloading JDK $JDK_VERSION ($JDK_BUILD)...'
        wget -q --show-progress -O \"$INSTALL_DIR/jdk.tar.gz\" \"$DOWNLOAD_URL\"
        if [ $? -ne 0 ]; then
            echo 'Error: Failed to download JDK.'
            exit 1
        fi

        # Extract the JDK
        echo 'Extracting JDK...'
        tar -xzf \"$INSTALL_DIR/jdk.tar.gz\" -C \"$INSTALL_DIR\" --strip-components=1
        if [ $? -ne 0 ]; then
            echo 'Error: Failed to extract JDK.'
            exit 1
        fi
        rm \"$INSTALL_DIR/jdk.tar.gz\"

        # Set environment variables in .bashrc
        if ! grep -q 'JAVA_HOME=$INSTALL_DIR' ~/.bashrc; then
            echo 'Setting up environment variables...'
            echo 'export JAVA_HOME=$INSTALL_DIR' >> ~/.bashrc
            echo 'export PATH=\$JAVA_HOME/bin:\$PATH' >> ~/.bashrc
        fi

        # Apply environment variables
        echo 'Applying environment variables...'
        source ~/.bashrc

        # Verify installation
        echo 'Verifying JDK installation...'
        java -version
    "
}

# Main script execution
create_pet_clinic_user
install_jdk_as_pet_clinic
