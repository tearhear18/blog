# BLOG API
## USAGE 
First setup 
```bash 
    docker compose up --build
```
Database Setup
```bash
    docker compose run web rails db:setup
```
RSPEC
```bash
    docker compose run web rspec
```
AUTHORIZATION
get the access_token from login
use access token to Bearer Token Header Authentication
