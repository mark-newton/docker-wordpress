FROM wordpress:cli-2.5.0

# Get args from docker-compose.yml
ARG wp_url
ARG wp_user
ARG wp_password
ARG wp_email
ARG wp_timezone
ARG wp_lang
ARG wp_title
ARG wp_description
ARG wp_debug
ARG wp_theme
ARG wp_plugins

# Default env
ENV WP_URL="$wp_url" \
  WP_USER=$wp_user \
  WP_PASSWORD=$wp_password \
  WP_EMAIL=$wp_email \
  WP_TIMEZONE="$wp_timezone" \
  WP_LANG="$wp_lang" \
  WP_TITLE="$wp_title" \
  WP_DESCRIPTION="$wp_description" \
  WP_DEBUG=$wp_debug \
  WP_THEME=$wp_theme \
  WP_PLUGINS=$wp_plugins

# copy install script with permissions
COPY docker-install.sh /usr/local/bin/
USER root
RUN chmod 755 /usr/local/bin/docker-install.sh
RUN mv /usr/local/bin/wp /usr/local/bin/_wp && \
  echo -e '#!/bin/sh\n_wp --allow-root "$@"' > /usr/local/bin/wp && \
  chmod +x /usr/local/bin/wp

CMD [ "docker-install.sh" ]
