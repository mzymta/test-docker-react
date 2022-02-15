FROM node:16-alpine as builder
WORKDIR /usr/temp/app
COPY ./package*.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=builder /usr/temp/app/build /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]



