# FROM node:14

# # See https://crbug.com/795759
# RUN apt-get update && apt-get install -yq xvfb gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 \
#       libdbus-1-3 libexpat1 libfontconfig1 libgbm1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 \
#       libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 \
#       libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 \
#       libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget && \
#     rm -rf /var/lib/apt/lists/*

# # Install latest chrome dev package and fonts to support major 
# # charsets (Chinese, Japanese, Arabic, Hebrew, Thai and a few others)
# # Note: this installs the necessary libs to make the bundled version 
# # of Chromium that Puppeteer
# # installs, work.
# RUN apt-get update && apt-get install -y wget --no-install-recommends \
#     && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
#     && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
#     && apt-get update \
#     && apt-get install -y google-chrome-unstable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst ttf-freefont \
#       --no-install-recommends \
#     && rm -rf /var/lib/apt/lists/* \
#     && apt-get purge --auto-remove -y curl \
#     && rm -rf /src/*.deb

# # It's a good idea to use dumb-init to help prevent zombie chrome processes.
# ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 /usr/local/bin/dumb-init
# RUN chmod +x /usr/local/bin/dumb-init

# # Uncomment to skip the chromium download when installing puppeteer. 
# # If you do, you'll need to launch puppeteer with:
# #     browser.launch({executablePath: 'google-chrome-unstable'})
# # ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

# # Copy the app
# COPY . /app/
# # COPY local.conf /etc/fonts/local.conf
# WORKDIR app
# COPY package*.json ./
# # uncomment it when running for the first time after clone repo
# RUN npm install
# COPY . .

# # Add user so we don't need --no-sandbox.
# RUN groupadd -r pptruser && useradd -r -g pptruser -G audio,video pptruser \
#     && mkdir -p /home/pptruser/Downloads \
#     && chown -R pptruser:pptruser /home/pptruser \
#     && chown -R pptruser:pptruser ./node_modules

# # Run everything after as non-privileged user.
# USER pptruser

# # https://github.com/nsourov/Puppeteer-with-xvfb
# RUN npm i -g pm2

# EXPOSE 6000

# ENTRYPOINT ["dumb-init", "--"]

# # # run when deployed (for development use "npm run dev")
# # CMD ["npm", "start"]
# CMD ["npm", "run", "dev"]









# First, we need to make sure all dependencies are there. If you are using docker, then the important dependencies are already present on most node images. 
FROM node:14

# To run Headful mode, you will need to have a display, which is not present in a server. 
# To avoid this, we will use Xvfb, and create a fake display, so the chrome will think there is a display and run properly. 
# So we just need to install Xvfb and Puppeteer related dependencies.
RUN apt-get update && apt-get install -yq wget gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget x11vnc x11-xkb-utils xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic x11-apps xvfb

# I am going to ignore dumb-init or such for now since it will add complexities to understand what is actually needed here. 

# Assuming we are working on /app folder, cd into /app
WORKDIR /app

# Copy package.json into app folder
COPY package.json /app

# Install dependencies
RUN npm install 

COPY . /app




# Add user so we don't need --no-sandbox.
RUN groupadd -r pptruser && useradd -r -g pptruser -G audio,video pptruser \
    && mkdir -p /home/pptruser/Downloads \
    && chown -R pptruser:pptruser /home/pptruser \
    && chown -R pptruser:pptruser ./node_modules

# Run everything after as non-privileged user.
USER pptruser




# Start server on port 3000
EXPOSE 3000

# I'll also assume you are going to use root user, 
# and your script has `--no-sandbox` and `--disable-setuid-sandbox` arguments.
# We run a fake display and run our script.
# Start script on Xvfb
CMD xvfb-run --server-args="-screen 0 1024x768x24" npm start