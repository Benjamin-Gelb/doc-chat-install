#!/bin/bash

# Function to check if a program is installed
is_installed() {
    command -v "$1" >/dev/null 2>&1
}

# Check and install MongoDB
if ! is_installed mongod; then
    echo "MongoDB is not installed. Installing MongoDB..."
    sudo apt update
    sudo apt install -y mongodb
    echo "MongoDB installation completed."
else
    echo "MongoDB is already installed."
fi

# Check and install Python
if ! is_installed python3; then
    echo "Python is not installed. Installing Python..."
    sudo apt update
    sudo apt install -y python3
    echo "Python installation completed."
else
    echo "Python is already installed."
fi

# Check and install Node.js
if ! is_installed node; then
    echo "Node.js is not installed. Installing Node.js..."
    curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    sudo apt-get install -y nodejs
    echo "Node.js installation completed."
else
    echo "Node.js is already installed."
fi

# Check and install npm (Node.js package manager)
if ! is_installed npm; then
    echo "npm (Node.js package manager) is not installed. Installing npm..."
    sudo apt-get install -y npm
    echo "npm installation completed."
else
    echo "npm is already installed."
fi

# Define the local directory where you want to clone the repositories
# Determine the directory where the script was executed
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Define the local directory where you want to clone the repositories
LOCAL_DIR="$SCRIPT_DIR"

# Define the URLs of the Git repositories you want to clone
REPO1_URL="https://github.com/Benjamin-Gelb/doc-chat-server"
REPO2_URL="https://github.com/Benjamin-Gelb/doc-chat"

# Clone the first repository
echo "Cloning repository 1..."
git clone "$REPO1_URL" "$LOCAL_DIR/doc-chat-server"

# Check if the clone was successful
if [ $? -eq 0 ]; then
    echo "Repository 1 cloned successfully."
else
    echo "Failed to clone repository 1."
    exit 1
fi

# Clone the second repository
echo "Cloning repository 2..."
git clone "$REPO2_URL" "$LOCAL_DIR/doc-chat"

# Check if the clone was successful
if [ $? -eq 0 ]; then
    echo "Repository 2 cloned successfully."
else
    echo "Failed to clone repository 2."
    exit 1
fi

echo "All repositories cloned successfully to $LOCAL_DIR."

echo "Installing dependencies listed in requirements.txt..."
pip install -r $LOCAL_DIR/doc-chat-server/requirements.txt

# Check if the installation was successful
if [ $? -eq 0 ]; then
    echo "Dependencies installed successfully."
else
    echo "Failed to install dependencies. Please check the requirements.txt file and try again."
    exit 1
fi

echo "Installing npm dependancies..."
npm --prefix $LOCAL_DIR/doc-chat install 

if [ $? -eq 0 ]; then
    echo "npm install in '$LOCAL_DIR/doc-chat' completed successfully."
else
    echo "npm install in '$LOCAL_DIR/doc-chat' failed."
    exit 1
fi