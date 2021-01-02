# SQL-EOT

## Development Guidance
- Put all backend APIs in `./apis`
- YOU MUST PUT `require("./utils.php");` BEFORE ANYTHING IN EVERY PHP CODES.
- The frontend is built with Vue2, all the codes are in `./sql-fe`
- DO NOT EDIT `Dockerfile`, `./docker-compose/*` UNLESS YOU KNOW WHAT YOU ARE DOING
- You can edit [`docker-compose.yml` to change the app's port which in line 22](https://github.com/FalconLee1011/SQL-EOT/blob/master/docker-compose.yml#L22), the default is 8022.

## Prerequisites
- [npm](https://www.npmjs.com/get-npm) 15.3 or later
- [Vue cli](https://cli.vuejs.org/) 4.5.8 or later
- [docker](https://www.docker.com/get-started) and [docker-compose](https://docs.docker.com/compose/install/) (Optional, only if you do not want a web server)
- XAMPP (Optional, only if you do not want docker)
- ~~A web server like [200OK](https://chrome.google.com/webstore/detail/web-server-for-chrome/ofhbbkphhbklhfoeikjpcbhemlocgigb), [python's http.server](https://docs.python.org/3/library/http.server.html) or even better [Nginx](https://www.nginx.com/) (Optional, only if you do not want docker)~~

## Testing & Deployment
### With Docker
- Clone this repository
  - `git clone https://github.com/FalconLee1011/SQL-EOT`
- Build the frontend
  - `cd ./SQL-EOT/sql-fe`
  - `npm install`
  - `npm run build`
- Docker build and run
  - `cd ..`
  - `sudo docker-compose build app`
  - `sudo docker-compose up -d`
  - Use `sudo docker ps` to confirm that you have following containers running.
    - jacnginx
    - just-a-container-app
    - Example of output for `sudo docker ps`
      ```
      CONTAINER ID  IMAGE             COMMAND                 CREATED        STATUS        PORTS                   NAMES
      aaaaaaaaaaaa  nginx:alpine      "/docker-entrypoint.…"  9 minutes ago  Up 2 minutes  0.0.0.0:8022->80/tcp    jacnginx
      bbbbbbbbbbbb  just-a-container  "docker-php-entrypoi…"  9 minutes ago  Up 2 minutes  9000/tcp                just-a-container-app
      cccccccccccc  mariadb           "docker-entrypoint.s…"  3 minutes ago  Up 3 minutes  0.0.0.0:8306->3306/tcp  jacFxxkMaria
      ```
- Configure SQL Connection  
  - Use `docker inspect jacFxxkMaria | grep IP` to get mariaDB's docker IP
  - `cd ./apis`
  - `cp ./db_conn.php.example db_conn.php`
  - Configure following variables
    - user
    - password
    - host
    - port
- Testing
  - Visit the app from your browser @ `http://localhost:8022/`
  - Call the app' APIs from your browser @ `http://localhost:8022/api/<api_file>`

### Without Docker
- Combine XAMPP is possible but untested.
- The original way to deploy without docker is not possible due to the need of mariaDB's docker image and php's dependency.

### ~~Without Docker (Not recommended, but easier)~~
- ~~Clone this repository~~
  - ~~`git clone https://github.com/FalconLee1011/SQL-EOT`~~
- ~~Build the frontend~~
  - ~~`cd ./SQL-EOT/sql-fe`~~
  - ~~`npm install`~~
  - ~~`npm run build`~~
- S~~tart the php web server at repository root~~
  - ~~`cd ..`~~
  - ~~`php -S localhost:8080`~~
  - ~~`python3 -m http.server` (if you use python's http.server module)~~
- ~~Testing~~
  - ~~Visit the app from your browser @ `http://localhost:8080/sql-fe`~~
  - ~~Call the app' APIs from your browser @ `http://localhost:8080/api/<api_file>`~~

## Others
- This app has been tested on Manjaro 20.2 and it work like a charm.