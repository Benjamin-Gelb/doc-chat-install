# doc-chat-install
Quick installation bash script for **Mac** and **Linux** users for doc-chat and doc-chat-server.
While Docker basically serves the exact same purpose but this is more expedient for my immediate needs.

## Clone

Clone this repository and ```cd``` into the project folder.
The run the following:
```bash
chmod +x install.sh
./install.sh
``` 
Then it will clone the Repositories and within the project directory.

## .env

The **doc-chat-server** requires you to set up a **.env** file:
```bash
cd doc-chat-server
touch .env
```
> Then open up a text-editor and provide for the following keys:
```bash
CHROMA_PATH="/path/to/dbstorage" # My preference is to place this in the local directory
MONGODB_URI="mongodb://localhost:27017/test" # Default for MongoDB
CLIENT_HOST="http://localhost:5173" # Default for vite
OPENAI_API_KEY="..." # Provide your own
```
## .env.local
The **doc-chat** Vite front-end also requires reference to the server.
> From /doc-chat-install
```bash
cd doc-chat
touch .env.local
```
> Then provide for the following keys
```bash
VITE_LLM_SERVER="http://localhost:5000" # Default for Flask servers
```
