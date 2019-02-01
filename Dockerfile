FROM fluent/fluentd:edge-onbuild

# Use root account to use apk
USER root

RUN apk add --no-cache --update --virtual .build-deps sudo build-base ruby-dev \
    && gem sources --clear-all \
    && fluent-gem install fluent-plugin-elasticsearch \
    && fluent-gem install fluent-plugin-fields-autotype \
    && fluent-gem install fluent-plugin-record-modifier --no-document \
    && fluent-gem install fluent-plugin-rewrite-tag-filter \
    && fluent-gem install fluent-plugin-remote_syslog \
    && apk del .build-deps \
    && rm -rf /home/fluent/.gem/ruby/2.5.0/cache/*.gem

USER fluent
