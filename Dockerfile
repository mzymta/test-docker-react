FROM node:16-alpine as deps
WORKDIR /usr/temp/app
COPY ./package*.json ./
RUN npm install
COPY ./ ./

FROM node:16-alpine as builder
WORKDIR /usr/temp/app
COPY --from=deps /usr/temp/app/node_modules ./node_modules
COPY ./ ./
RUN npm run build

FROM nginx:alpine
EXPOSE 80
COPY --from=builder /usr/temp/app/build /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
