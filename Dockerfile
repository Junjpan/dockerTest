# this is a parent image, the first layer, pull in the node image into our image as the inital layer
# it's going to pull it either from the docer hub repository if we haven't already downloaded or our own computer if we already downloaded
#alpine is the distribution of linux
FROM node:17-alpine
# install nodemon and make it run globally within the image or container
RUN npm install -g nodemon
# set up work directory,
# tells docker that when run commands on the below working directory, so later on when we run npm install within the image
# it will run inside the /app folder
WORKDIR /app
# copy source package.json to the image, the image working directory is relative to the WORKDIR,
# we move the package.json file here first so that docker can save time to build the image, cache all the layer
# because a lot of time only source code is changed, great explanation can be found here:https://www.youtube.com/watch?v=_nMpndIyaBU&t=2s
COPY package.json .
# install dependecies and specify the commands that we want to run in the image as the image gets built
# tell dockers to run a command on the image itself based on all the depencies in the package.json file
RUN npm install
#tell docker what port is going to be exposed by the container, It's kind of optional,we only need it here when
#we are using the docker desktop application. But if we're running containers from the command line,then it's not really need
# copy source code to the image, the image working directory is relative to the WORKDIR
COPY . .

EXPOSE 4000
#CMD allows us to specifiy any commands that should be run at runtime when the container begins to run
#We can't just directly RUN node app.js because we don't want to run on the image.
CMD ["npm","run","dev"]  