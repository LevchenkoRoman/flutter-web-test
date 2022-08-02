#Stage 1 - Install dependencies and build the app
FROM cirrusci/flutter:stable AS build-env

# Copy files to container and build
RUN mkdir /app/
COPY . /app/
WORKDIR /app/
RUN flutter pub get
RUN flutter build web --release

# Stage 2 - Create the run-time image
FROM nginx:latest
COPY --from=build-env /app/build/web /usr/share/nginx/html