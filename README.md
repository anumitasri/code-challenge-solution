This is the solution to the Coding Challenge for the SDET position.
There are 3 parts to this document:
1. Containerization using Docker
2. Setting up CI/CD tools
3. Automated testing 


### Notes for setting up Node.js environment :
In order to first set up npm:
1. mkdir ~/.npm-global
2. npm config set prefix '~/.npm-global'
3. export PATH=~/.npm-global/bin:$PATH
4. source ~/.profile
5. npm install -g bs-platform

6. Then go to your app directory by cd /Usr/your-app-dir
7. npm install
8. npm start 

This will let you view your web app in the browser.

### Notes: STEP 1 -> To create a docker container:

1. use vim/touch to create a Dockerfile in your project
2. For example vim Dockerfile
3. Paste the following code in the Dockerfile:
FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
CMD  ["npm","start"] 


4. In the terminal, enter the following :  docker build . -t reactimage
5. Then by writing " docker image ls " you will be able to see a list of all the images currently available.
6. 



