FROM node:14
WORKDIR /app
COPY package*.json ./
# uncomment it when running for the first time after clone repo
RUN npm install
COPY . .
EXPOSE 6000
# # run when deployed (for development use "npm run dev")
# CMD ["npm", "start"]
CMD ["npm", "run", "dev"]