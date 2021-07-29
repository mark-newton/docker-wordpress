# docker-wordpress

Run wordpress in docker with installer that uses env variables via wp-cli

### Usage
- Copy .env.example to .env and modify as required
- Makefile included for building, starting, stopping
- The cli container will extract .env variables for initialising Wordpress once installed
- Shared volumes created for db (vol-db) and wordpress files (vol-wp) for backing up and/or including in a git repo
