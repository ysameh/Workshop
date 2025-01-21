# Pet Clinic Setup Script

This script automates the process of setting up a new user and installing the Java Development Kit (JDK) version 17 for a user named `pet-clinic` on a Linux system.

## Prerequisites

Before running the script, ensure the following:

- Your system has internet access to download the JDK.
- The `wget` command is available to download files.
- You are using a Linux-based operating system.

## Script Overview

The script performs the following tasks:

1. **Create a `pet-clinic` user**:
   - If the `pet-clinic` user already exists, it simply notifies you and does nothing.
   - If the user does not exist, it creates a new user and sets a password.

2. **Install JDK version 17**:
   - Downloads and installs JDK version 17 (build 17.0.12).
   - Configures the `JAVA_HOME` environment variable and adds it to the user's `~/.bashrc` file.
   - Verifies the installation of the JDK by running `java -version`.

## Script Functions

### `create_pet_clinic_user`

- This function checks if the `pet-clinic` user already exists.
- If the user does not exist, it creates the user and prompts for a password.

### `install_jdk_as_pet_clinic`

- This function installs JDK version 17 for the `pet-clinic` user.
- It downloads the JDK from Oracle's official repository.
- It extracts the JDK tarball to a specific directory and configures the `JAVA_HOME` environment variable.
- Finally, it verifies the installation by checking the JDK version.

## Usage

### Running the Script

1. **Download or clone the script to your server**:
   You can either download the script or clone it from your repository.

2. **Make the script executable**:
   ```bash
   chmod +x pet-clinic_setup.sh
   ```

3. **Execute the script**:
   Run the script 
   ```bash
   ./pet-clinic_setup.sh
   ```

4. **Set a password**:  
   When prompted, enter the password for the new `pet-clinic` user.

5. **Wait for the installation to complete**:  
   The script will download and install the JDK, set up environment variables, and verify the installation.

### Example Output

```
Creating user 'pet-clinic'...
Please set a password for the 'pet-clinic' user:
Changing password for user pet-clinic.
Retype new password: 
User 'pet-clinic' created successfully.
Switching to 'pet-clinic' user...
Please enter your password
Creating installation directory at /home/pet-clinic/java_17...
Downloading JDK 17 (17.0.12)...
Extracting JDK...
Setting up environment variables...
Applying environment variables...
Verifying JDK installation...
openjdk version "17.0.12" 2021-07-20
OpenJDK Runtime Environment (build 17.0.12+7)
OpenJDK 64-Bit Server VM (build 17.0.12+7, mixed mode)
```

### Troubleshooting

- If the JDK fails to download, make sure your internet connection is stable and that the URL is accessible from your machine.
- Ensure that you have the required permissions to run the script (i.e., the ability to create users and install software).
- If the JDK installation fails, check if the directory exists and if the user has permission to write to it.

## Customization

- **JDK Version**: You can modify the `JDK_VERSION` and `JDK_BUILD` variables within the script to install a different version of JDK if needed.
- **Installation Directory**: Change the `INSTALL_DIR` variable to modify where the JDK will be installed.

