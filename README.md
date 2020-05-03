This is the solution to the Coding Challenge for the SDET position.
There are 3 parts to this document:
1. Containerization using Docker
2. Setting up CI/CD tools
3. Automated testing 

############################################################################################
### Instructions for setting up Node.js environment :
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
    1. FROM node:alpine 
    2. WORKDIR '/app'
    3. COPY package.json .
    4. RUN npm install
    5. COPY . .
    6. CMD  ["npm","start"] 


4. In the terminal, enter the following :  docker build . -t reactimage
5. Then by writing " docker image ls " you will be able to see a list of all the images currently available.
6. Then enter the ocmmande "docker run reactimage "
7. Open another terminal and write "docker ps". This will show you a list of all the images with their container ids.
8. Now execute the required image by mentioning it's id by doing : "docker exec -it container_id  sh"
9. To see the container with web app, write " npm start".  The app will run on the localhost at port 3001.

############################################################################################

### STEP 2 ->  CI/CD FRAMEWORK SETUP - Using CircleCi, CodeClimate and Heroku

1. Create a folder in your root and name it .circleci
2. Create a config.yml file in the .circleci folder.
3. Enter the following code in config.yml :
    version: 2
    jobs:
    build:
    docker:
      - image: circleci/node:8

    steps:
      - checkout
      - restore_cache: 
          key: dependency-cache-{{ checksum "package.json" }}-{{ checksum "package-lock.json" }}
      - run:
          name: Setup Dependencies
          command: npm install
      - run:
          name: Setup Code Climate test-reporter
          command: |
            curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > ./cc-test-reporter
            chmod +x ./cc-test-reporter
      - save_cache: 
          key: dependency-cache-{{ checksum "package.json" }}-{{ checksum "package-lock.json" }}
          paths:
            - ./node_modules
      
      - run: # run tests
          name: Run Test and Coverage
          command: |
            ./cc-test-reporter before-build
            npm test -- --coverage
            ./cc-test-reporter after-build --exit-code $?

4. Sign in to CircleCI and initialze your git repository and run build. (there will be an error in the first build.)
5. Sign in to Codeclimate next and initialize your git repository and run build.
6. Go to Settings > Test Coverage and copy the Test Reporter ID.
7. Go back to CircleCI > settings > Environment Variables. Then add CC_TEST_REPORTER_ID and set its value to the Codeclimate test reporter Id.
8. Once this is tun, run build on your project and the build should be successful.
9. To set up Heroku, login to create an account. 
10. In your terminal, run brew tap heroku/brew && brew install heroku to install heroku on your local machine.
11. Initialize your git repository and push it to heroku by "git push heroku master"
12. Go to Heroku dashboard, click on the Deploy tab and Connect to the correct GitHub repo.
13. Next enable Automatic deployment and click on the  "Wait for CI to pass before deploy" check box.
14. Your Heroku app is now ready to be deployed.


############################################################################################

### STEP 3 ->  Automated Testing

1. Jest is used for application testing.
2. Infrastructure testing is handled by CircleCi
3. Performance testing is done in the browser by using Developer Tools > Performance.