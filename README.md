# User Setup Script

This script automates the process of setting up a new users and installing the Java Development Kit (JDK) version 17 for multiple users on a Linux system.

## Prerequisites

Before running the script, ensure the following:

- Your system has internet access to download the JDK.
- The `wget` command is available to download files.
- Ensure OpenSSL is installed on the system to encrypt/decrypt credentials and hash passwords.
- Having an encrypted file with the list of users and their passwords.
- You are using a Linux-based operating system.


## Script Overview

The script performs the following tasks:

1. **Create user**:
   - If the user already exists, it simply notifies you and does nothing.
   - If the user does not exist, it creates a new user and sets the password.

2. **Install JDK**:
   - Downloads and installs JDK version 17 (build 17.0.12).
   - Configures the `JAVA_HOME` environment variable and adds it to the user's `~/.bashrc` file.
   - Verifies the installation of the JDK by running `java -version`.

3. **Decrypt the credentials**
   - Decrypts users credentials and adds them to an array

## Script Functions

### `create_user`

- This function checks if the user already exists.
- If the user does not exist, it creates the user and sets the password.

### `install_jdk`

- This function installs JDK version 17 for the user.
- It downloads the JDK from Oracle's official repository.
- It extracts the JDK tarball to a specific directory and configures the `JAVA_HOME` environment variable.
- Finally, it verifies the installation by checking the JDK version.

### `decrypt_credentials`

- Decrypts the `credentials.enc` file using OpenSSL and the provided `DECRYPTION_KEY`.
- Each line is read into an array (`USER_CREDENTIALS`), where each element is in the format `username=password`.

## Steps to prepare the Encrypted file

1. **Create a plain text file named `credentials.txt` with multiple key-value pairs

```
user1=password1
user2=password2

```

2. **Encrypt the file**

```bash
openssl enc -aes-256-cbc -pbkdf2 -in credentials.txt -out credentials.enc -k your_decryption_key
```

3. **Delete the text file for security**

```bash
rm credentials.txt
```


## Usage

### Running the Script

1. **Download or clone the script to your server**:
   You can either download the script or clone it from your repository.

2. **Add the encrypted file to the directory**
   Make sure to add the decryption key in the script

3. **Make the script executable**:
   ```bash
   chmod +x user_setup.sh
   ```

4. **Execute the script**:
   Run the script 
   ```bash
   ./user_setup.sh
   ```

5. **Wait for the installation to complete**:  
   The script will download and install the JDK, set up environment variables, and verify the installation.

### Example Output

``` 
Creating user 'user1'...
[sudo] password for adminuser: 
User 'user1' created successfully.
Switching to 'user1' user...
Password: 
Creating installation directory at /home/user1/java_17...
Downloading JDK 17 (17.0.12)...
/home/user1/ja 100%[===================>] 174.33M  2.10MB/s    in 87s     
Extracting JDK...
Setting up environment variables...
Applying environment variables...
Verifying JDK installation...
java version "17.0.12" 2024-07-16 LTS
Java(TM) SE Runtime Environment (build 17.0.12+8-LTS-286)
Java HotSpot(TM) 64-Bit Server VM (build 17.0.12+8-LTS-286, mixed mode, sharing)

```

### Troubleshooting

- If the JDK fails to download, make sure your internet connection is stable and that the URL is accessible from your machine.
- Ensure that you have the required permissions to run the script (i.e., the ability to create users and install software).
- If the JDK installation fails, check if the directory exists and if the user has permission to write to it.
- Ensure that credentials file is in the same directory and decryption key is correct.

## Customization

- **JDK Version**: You can modify the `JDK_VERSION` and `JDK_BUILD` variables within the script to install a different version of JDK if needed.
- **Installation Directory**: Change the `INSTALL_DIR` variable to modify where the JDK will be installed.

