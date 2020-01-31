# apache-php72
#ApachePHP - MYSQL - Phpmyadmin

My docker-compose.yml:


version: "3.0"
services:
  webserver:
    image: ppuppim/apache-php72:latest
    ports: 
      - "80:80"
    volumes: 
      - "/Users/youruser/projects/:/var/www/html"

  mysql:
    image: mysql/mysql-server:5.7
    command: --default-authentication-plugin=mysql_native_password
    restart: always
    environment:
     MYSQL_ROOT_PASSWORD: 123
     MYSQL_ROOT_HOST: '%'
    volumes:
     - "/Users/youruser/db/mysql:/var/lib/mysql"     
    ports: 
     - "3306:3306"

  phpmyadmin:
    image: phpmyadmin/phpmyadmin:latest
    ports:
      - 8050:80          
    environment:
      PMA_PORT: 3306
      PMA_HOST: mysql
      PMA_USER: root
      PMA_PASSWORD: 123

