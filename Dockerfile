FROM node:alpine
COPY . app/
WORKDIR '/app'
RUN npm ci --only-production
RUN npm run build
EXPOSE 5000
ENTRYPOINT npm run start
