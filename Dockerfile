FROM alpine:latest

RUN apk add --no-cache curl bash

# Add the scripts
COPY bin/freedns_update.sh bin/crontab_update.sh /bin/

# Make the scripts runnable
RUN chmod +x /bin/freedns_update.sh && \
    chmod +x /bin/crontab_update.sh

# Make the key file directory
RUN mkdir /var/local/dns_updater

# First run the freedns_update script and set cron running
CMD /bin/crontab_update.sh && /bin/freedns_update.sh && crond -d 6 -f
