SELECT new_shortened_url('https://www.google.es/');
SELECT new_shortened_url('https://www.google.es/', 'http://unizar.es/');
SELECT new_shortened_url('https://www.google.es/', 'http://unizar.es/', 15);
SELECT new_shortened_url('https://www.google.es/', 'https://github.com/orgs/UNIZAR-30246-2018-BLUE-BOMB/dashboard');
SELECT new_shortened_url('https://github.com/orgs/UNIZAR-30246-2018-BLUE-BOMB/dashboard', 'https://www.google.es/');


CREATE USER blueBomb WITH ENCRYPTED PASSWORD 'unizar';
GRANT USAGE ON SCHEMA public to blueBomb;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public to bluebomb;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public to bluebomb;
GRANT SELECT ON ALL TABLES IN SCHEMA public to blueBomb;
GRANT INSERT ON ALL TABLES IN SCHEMA public to blueBomb;
GRANT UPDATE ON ALL TABLES IN SCHEMA public to blueBomb;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO blueBomb;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT INSERT ON TABLES TO blueBomb;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT UPDATE ON TABLES TO blueBomb;