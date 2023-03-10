WORDPRESS_TOOLBOX=@docker-compose run --rm toolbox

start:
	docker-compose up -d --remove-orphans

stop:
	docker-compose stop

install: start wordpress_configure wordpress_install_plugins wordpress_set_theme fix_permssions2

fix_permssions2:
	docker-compose exec -T wordpress chmod -R 755 /var/www/html

wordpress_configure:
	docker-compose exec -T wordpress chmod -R 777 /var/www/html
	$(WORDPRESS_TOOLBOX) run_configure
	$(WORDPRESS_TOOLBOX) run_configure_url
	@echo "✅ WordPress is configured."

wordpress_fix_permissions:
	docker-compose exec -T wordpress chown www-data /var/www/html/wp-content
	docker-compose exec -T wordpress chown www-data /var/www/html/wp-content/plugins
	docker-compose exec -T wordpress chown www-data /var/www/html/wp-content/themes

wordpress_install_plugins: wordpress_fix_permissions
	@echo "➡️ Installing and activating plugins..."
	$(WORDPRESS_TOOLBOX) run_install_plugins
	@echo "✅ WordPress plugins are installed."

wordpress_migrations_generate:
	$(WORDPRESS_TOOLBOX) run_migrations_generate

wordpress_migrations_execute:
	$(WORDPRESS_TOOLBOX) run_migrations_execute

wordpress_set_theme:
	$(WORDPRESS_TOOLBOX) run_set_theme

run_configure:
	wp-cli config create \
		--dbhost=${MYSQL_HOST} \
		--dbname=${MYSQL_DATABASE} \
		--dbuser=${MYSQL_USER} \
		--dbpass=${MYSQL_USER_PASSWORD} \
		--locale=${WORDPRESS_LOCALE} \
		--skip-check \
		--force

	wp-cli core install \
		--url=${WORDPRESS_DOMAIN_NAME} \
		--title="$(WORDPRESS_WEBSITE_TITLE)" \
		--admin_user=${WORDPRESS_ADMIN_USER} \
		--admin_password=${WORDPRESS_ADMIN_PASSWORD} \
		--admin_email=${WORDPRESS_ADMIN_EMAIL}
	wp-cli language core install ${WORDPRESS_LOCALE} --activate --allow-root

run_configure_url:
	wp-cli option update siteurl "${WORDPRESS_WEBSITE_URL}"
	wp-cli option update home "${WORDPRESS_WEBSITE_URL}"
	wp-cli rewrite structure $(WORDPRESS_WEBSITE_POST_URL_STRUCTURE)
	wp-cli rewrite flush

run_install_plugins:
	wp-cli plugin install contact-form-7 --activate
	wp-cli plugin install mailchimp-for-wp --activate
	wp-cli plugin install advanced-custom-fields --activate
	wp-cli plugin activate wp-migrations

run_migrations_generate:
	wp-cli migrations generate

run_migrations_execute:
	wp-cli migrations execute

run_set_theme:
	wp-cli theme activate my-simple-theme
