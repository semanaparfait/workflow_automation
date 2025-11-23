# 1. BASE IMAGE: Start with a lightweight, official Node.js image (e.g., Node 20 Slim)
FROM node:20-slim

# 2. WORKING DIRECTORY: Set the directory inside the container
WORKDIR /usr/src/app

# 3. CACHING LAYER: Copy only package files first. 
# This leverages Docker's cache. If only code changes (not dependencies), 
# this step is skipped on subsequent builds, speeding them up.
COPY package*.json ./

# 4. INSTALL DEPENDENCIES: Install all packages listed in package.json
RUN npm install

# 5. CODE COPY: Copy the rest of the application files (including your workflow JSON)
COPY . .

# 6. PORT: Tell Docker which port the app listens on (standard for n8n is 5678)
EXPOSE 5678

# 7. START COMMAND: Define the command that runs when the container launches
# This uses the 'start' script defined in your package.json
CMD ["npm", "start"]