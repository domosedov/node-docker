FROM node:lts-alpine AS dev
WORKDIR /usr/src/app
COPY package.json ./
RUN npm i
COPY . .
RUN npm run build

FROM node:lts-alpine AS prod
ENV NODE_ENV=production
WORKDIR /usr/src/app
COPY package.json ./
RUN npm i
COPY . .
COPY --from=dev /usr/src/app/dist ./dist
EXPOSE 8000
RUN chown -R node /usr/src/app
USER node
CMD ["node", "dist/index.js"]
