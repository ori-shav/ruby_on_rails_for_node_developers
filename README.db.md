# Set up a container running a POSTGRESQL db in docker
docker run --name db -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=changeme -p 5432:5432 -d postgres

# PSQL commands
psql -h localhost --u postgres -p 5432
\l
\c railsondocker_development
\dt
\s
drop table railsondocker_development;
drop table articles cascade;