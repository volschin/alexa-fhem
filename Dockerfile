FROM node:18.16-alpine3.18
LABEL org.label-schema.name="alexa-fhem" \
      org.label-schema.description="Alexa-FHEM Schnittstelle" \
      org.label-schema.url="https://github.com/volschin" \
      org.opencontainers.image.authors="volschin@googlemail.com"

RUN apk add --no-cache --update git

RUN npm install --omit=dev -g volschin/alexa-fhem
COPY healthcheck.js /healthcheck.js
#VOLUME [ "/alexa-fhem" ]

EXPOSE 3000
HEALTHCHECK --interval=120s --timeout=12s --start-period=30s \  
 CMD node /healthcheck.js
USER node
#WORKDIR "/alexa-fhem"
ENTRYPOINT ["/usr/local/lib/node_modules/alexa-fhem/bin/alexa", "--dockerDetached"]
CMD ["/bin/sh"]
