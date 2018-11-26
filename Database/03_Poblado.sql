SELECT new_shortened_url('https://www.google.es/');
SELECT new_shortened_url('https://www.google.es/', 'http://unizar.es/');
SELECT new_shortened_url('https://www.google.es/', 'http://unizar.es/', 15);
SELECT new_shortened_url('https://www.google.es/', 'https://github.com/orgs/UNIZAR-30246-2018-BLUE-BOMB/dashboard');
SELECT new_shortened_url('https://github.com/orgs/UNIZAR-30246-2018-BLUE-BOMB/dashboard', 'https://www.google.es/');