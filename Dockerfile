FROM node:17.9

LABEL description="Dockerfile for building Docsify."

WORKDIR /zjzjzjzj-docsify

# Install Docsify CLI
RUN npm install -g docsify-cli@latest

# Copy the documentation source files
COPY . .

EXPOSE 3000/tcp