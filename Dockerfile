FROM node:22-slim

ARG TARGETARCH

RUN apt-get update \
    && apt-get install -y wget gnupg --no-install-recommends \
    # Install Chrome for amd64, Chromium for arm64
    && if [ "$TARGETARCH" = "amd64" ]; then \
        wget -q --no-check-certificate -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
        echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
        apt-get update && apt-get install -y google-chrome-stable; \
    else \
        apt-get install -y chromium; \
    fi \
    && apt-get install -y fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf \
    && rm -rf /var/lib/apt/lists/* \
    && wget --quiet https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -O /usr/sbin/wait-for-it.sh \
    && chmod +x /usr/sbin/wait-for-it.sh

# Set the correct browser command
CMD ["/bin/sh", "-c", "if [ \"$TARGETARCH\" = \"amd64\" ]; then google-chrome-stable; else chromium; fi"]
