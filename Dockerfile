FROM --platform=linux/amd64 node:18 AS builder

WORKDIR /app

COPY ./package.json .

RUN npm i --omit=dev

FROM --platform=linux/amd64 gcr.io/distroless/nodejs18-debian11

WORKDIR /app

COPY --from=builder /app .
COPY ./flows.json .
COPY ./index.js .

EXPOSE 8080

CMD ["index.js"]