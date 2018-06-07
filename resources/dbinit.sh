#!/bin/bash
set -e

# Initializes the database infrastructure for rasa-ui
# Setup scripts for tables are in dbcreate.sql

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	create user rasaui with password 'rasaui';
    create database rasaui;
    \c rasaui;
    \i dbcreate.sql
    grant all on database rasaui to rasaui;
    grant all privileges on all tables in schema public to rasaui;
    grant all privileges on all sequences in schema public to rasaui;
EOSQL
    