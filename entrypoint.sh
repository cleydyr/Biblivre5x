#!/bin/bash
set -e

# Start PostgreSQL in the background as postgres user
su - postgres -c "/usr/local/pgsql/bin/pg_ctl -D /var/lib/postgresql/data -l /var/lib/postgresql/data/logfile start"

# Wait for PostgreSQL to start
sleep 3

# Run initialization SQL if database is empty
if [ ! -f /var/lib/postgresql/data/.db_initialized ]; then
  su - postgres -c "/usr/local/pgsql/bin/psql -f /docker-entry-initdb.d/createdatabase.sql"
  # Populate biblivre4 database
  su - postgres -c "/usr/local/pgsql/bin/psql -d biblivre4 -f /docker-entry-initdb.d/biblivre4.sql"
  touch /var/lib/postgresql/data/.db_initialized
fi

# Start Tomcat in the foreground
exec $CATALINA_HOME/bin/catalina.sh run
