# Backend and Scrapers for KBPartpicker
## Setup Postgres
---
- Download Postgres
```
brew install postgres
```
- Create kbpartpicker database
```
createdb -h localhost -p 5432 -U {username} kbpartpicker
```
## Setup server
---
- Download the chromedriver that matches your chrome browser's version
https://chromedriver.chromium.org/downloads
- Install python dependencies (Be sure to use python 3)
```
pip install -r requirements.txt
```
- Create a `.env` file inside the `config` directory with the following as its contents, and replace username with the username you used to create the database
```
export DATABASE_URL=postgres+psycopg2://{username}:password@localhost:5432/kbpartpicker
export MODE=dev
export TEST=1
```
- run `pg_ctl -D /usr/local/var/postgres start` to start postgres server
- Run `source config/.env` to export local environment variables.
- Run `python scrape.py` to populate the database.
- Run `gunicorn -b 127.0.0.1:5000 app:app` to start the server.
