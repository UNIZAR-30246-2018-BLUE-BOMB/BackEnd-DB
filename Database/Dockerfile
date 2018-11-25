FROM postgres
WORKDIR /docker-entrypoint-initdb.d
ADD 01_Tablas.sql /docker-entrypoint-initdb.d
ADD 02_Funciones.sql /docker-entrypoint-initdb.d
ADD 03_triggers.sql /docker-entrypoint-initdb.d
ADD 04_Poblado.sql /docker-entrypoint-initdb.d
EXPOSE 5432
