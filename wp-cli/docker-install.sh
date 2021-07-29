#!/bin/sh
set -e

if [ ! -f wp-config.php ]; then
    echo "WordPress not found in $PWD!"
    ( set -x; sleep 15 )
fi

if ! $(wp core is-installed); then
    echo "Initializing WordPress install!"

    # core
    wp core install \
        --url="$WP_URL" \
        --admin_user=$WP_USER \
        --admin_password=$WP_PASSWORD \
        --admin_email=$WP_EMAIL \
        --title="$WP_TITLE" \
        --skip-email \
        --skip-plugins

    # settings
    wp option update blogdescription "$WP_DESCRIPTION"
    wp config set WP_DEBUG $WP_DEBUG --raw

    wp theme install $WP_THEME
    wp theme activate $WP_THEME

    wp option update timezone_string "$WP_TIMEZONE"

    wp language core install $WP_LANG
    wp language core activate $WP_LANG
    wp language theme update --all

    wp rewrite structure '/%postname%/'

    # plugins
    wp plugin delete akismet hello

    if [ -n "$WP_PLUGINS" ]; then
        echo "Installing plugins: $WP_PLUGINS"
        wp plugin install $WP_PLUGINS
        chown -Rh www-data.www-data . || true
        wp plugin activate --all
    fi

    # custom initial posts/pages script
    if [ -f /app/initialize.sh ]; then
        sh /app/initialize.sh
    fi

    # make everything owned by www-data
    chown -Rh www-data.www-data . || true
fi
