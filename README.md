WordPress, the automated way – DEMO
===================================

## Usage

### Prerequesites

The project requires the following tools to be built and run:

* Docker
* Docker Compose

### Download installation file

Download the file Docker installation with images for containers:

    wget -O installDockerWordpress.sh https://raw.githubusercontent.com/javierjuanJJ/auto-install-wordpress/master/installDockerWordpress.sh
    
Install docker with root permissions:

    sh installDockerWordpress.sh
    
    
### Clone repository

Clone the repository for install:

    git clone https://github.com/javierjuanJJ/auto-install-wordpress.git
    
You can rename folder:

    mv auto-install-wordpress <<wordpress name folder>>
    
You must change directory to <<wordpress name folder>>:

    cd <<wordpress name folder>>

### Define environment variables

Create a .env file at the root of the project with the following configuration:
    
    nano .env
    
Copy and paste all content in file and change ports and user information of environment variables.

    # PORTS
    
    WEBSERVER_NGINX_PORT=9000
    WEBSERVER_PORT=80
    FTP_ACTIVE_PORT=21
    FTP_PASSIVE_PORT_BEGIN=30000
    FTP_PASSIVE_PORT_END=30009
    PUBLICHOST=localhost
    MYSQL_PORT=3306
    PHPMYADMIN_PORT=8082
    
    # Mysql configuration
    
    MYSQL_ROOT_PASSWORD=my_root_password
    MYSQL_HOST=database
    MYSQL_DATABASE=wordpress
    MYSQL_USER=wordpress
    MYSQL_USER_PASSWORD=wordpress_pwd
    
    # Wordpress configuration
    
    WORDPRESS_DOMAIN_NAME="${PUBLICHOST}:${WEBSERVER_PORT}"
    WORDPRESS_WEBSITE_URL="http://${PUBLICHOST}:${WEBSERVER_PORT}"
    WORDPRESS_ADMIN_USERNAME=admin_wordpress
    WORDPRESS_ADMIN_PASSWORD=password_admin_wordpress
    WORDPRESS_ADMIN_EMAIL=admin_wordpress@gmail.com
    WORDPRESS_LOCALE=es_ES
    WORDPRESS_WEBSITE_TITLE="Title blog"
    
    # FTP configuration
    
    FTP_USER_NAME=user
    FTP_USER_PASS=password_ftp
    FTP_USER_HOME=/var/www/html

* `MYSQL_ROOT_PASSWORD`: Password for the *root* user in MySQL (no app should connect with it) — recommendation: complex password
* `MYSQL_HOST`: Host of the MySQL database. If using the Docker MySQL instance, set `database` (it is the Docker container name for the database, see *docker-compose.yml* file). If it is hosted on an external server, set the IP or host.
* `MYSQL_DATABASE`: Name of the MySQL database used for WordPress — recommendation: *wordpress*
* `MYSQL_USER`: MySQL username that WordPress will use to connect to the database — recommendation: *wordpress*
* `MYSQL_USER_PASSWORD`: Password for WordPress MySQL user — recommendation: complex password
* `WORDPRESS_DOMAIN_NAME`: Domain name of the Wordpress public address (the one seen from a browser).
* `WORDPRESS_WEBSITE_URL`: Domain name of the Wordpress public address with `http://` or `https://` at the beginning.
* `WORDPRESS_ADMIN_EMAIL`: Email address of the admin user for WordPress admin interface.
* `WORDPRESS_ADMIN_USERNAME`: Username of the admin user for WordPress admin interface (example: *admin*)
* `WORDPRESS_ADMIN_PASSWORD`: Password of the admin user (choose wisely!).
* `WEBSERVER_PORT`: **Port that will be exposed for Nginx** (Example if *8000* is chosen, the website will be locally available at http://localhost:8000).

* `WORDPRESS_LOCALE`: Language of Wordpress
* `WORDPRESS_WEBSITE_TITLE`: Title of wordpress
* `PUBLICHOST`: IP host
* `FTP_USER_NAME`: Username of user what it will connect to FTP_USER_HOME
* `FTP_USER_PASS`: Password of user what it will connect to FTP_USER_HOME
* `FTP_USER_HOME`: Path what connect host from wordpress. Normally is **/var/www/html**
* `FTP_USER_PASS`: Password of user what it will connect to FTP_USER_HOME

* `FTP_ACTIVE_PORT`: Active port FTP. Normally is **21**
* `FTP_PASSIVE_PORT_BEGIN`: Beginner passive port FTP.
* `FTP_PASSIVE_PORT_END`: END passive port FTP.
* `MYSQL_PORT`: MYSQL port.
* `PHPMYADMIN_PORT`: PHPMYADMIN port.

### Run project

Run installation first:

    make install

Start containers:

    make start

Visit http://localhost:8000

### Run phpMyAdmin

I have added phpMyAdmin for demonstration purpose of Docker Compose.

Access it on http://localhost:8082

### What does it do?

Running the `make install` command will:

* Create Docker containers for WordPress, MySQL and Nginx.
* Initiate the WordPress database.
* Configure WordPress:
    * Database parameters.
    * Default WordPress user.
    * Set language.
    * Set default URL structure.
* Activate the custom `my-simple-theme` theme.
* Install plugins (Contact Form 7 and WP MailChimp as examples).
* Create an "About us" page (which has a specific template in the custom theme).

☑️ The project should be then be up and running.

## Docker configuration

The following containers are created and configured in `docker-compose.yml`:

* *webserver*: A Nginx Docker image.
* *wordpress*: A WordPress Docker image with PHP 7.3.
* *database*: A MySQL Docker image.
* *toolbox*: A toolbox containing WP-CLI and running a Makefile.
* *ftp*: A container what is a ftp image what connect to FTP_USER_HOME

The `restart: always` instruction allows containers to get restarted if they stop for any reason
or when the server is restarted.
