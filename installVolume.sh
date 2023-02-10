docker volume create --driver local \
      --opt type=none \
      --opt device=./wordpress_data \
      --opt o=bind \
      automated-wordpress-demo_wordpress_data
