# 1. Use a specific, stable Node.js image
FROM node:20-slim

# 2. Install n8n globally and its dependencies first
# We use the /usr/local/bin directory which is globally visible.
USER root
RUN npm install -g n8n@1.64.3  # Use the exact version you want

# 3. Create the necessary configuration folder and set permissions
# This is where your SQLite database and credentials are saved (Persistence Mount Point)
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node/.n8n

# 4. Set the working directory (and switch back to a non-root user for security)
USER node
WORKDIR /home/node/

# 5. Copy the rest of your files (including your workflow JSON)
# We copy them to the home directory of the 'node' user
COPY --chown=node:node package*.json ./
COPY --chown=node:node . /home/node/

# 6. Define the command that runs when the container launches
# We explicitly run the globally installed n8n
CMD ["n8n", "start", "--config=/home/node/.n8n/config"]