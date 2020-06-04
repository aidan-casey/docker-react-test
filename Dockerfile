# # # # # # # # # # # # # # #
# Setup our build phase     #
# # # # # # # # # # # # # # #
FROM node:alpine as builder

# Setup the working directory
WORKDIR /var/www

# Install Node Dependencies
COPY package.json .
RUN npm install

# Copy over the code
COPY . .

# Build the application
RUN npm run build

# # # # # # # # # # # # # # #
# Now setup the run phase   #
# # # # # # # # # # # # # # #
FROM nginx

EXPOSE 80

# Copy the source code from the builder
COPY --from=builder /var/www/build /usr/share/nginx/html
