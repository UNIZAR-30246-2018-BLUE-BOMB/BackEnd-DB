SELECT new_shortened_url('https://www.google.es/');
SELECT new_shortened_url('https://www.google.es/', 'http://unizar.es/');
SELECT new_shortened_url('https://www.google.es/', 'http://unizar.es/', 15);
SELECT new_shortened_url('https://www.google.es/', 'https://github.com/orgs/UNIZAR-30246-2018-BLUE-BOMB/dashboard');
SELECT new_shortened_url('https://github.com/orgs/UNIZAR-30246-2018-BLUE-BOMB/dashboard', 'https://www.google.es/');

INSERT INTO os_stat (seq, date, os, click) VALUES ('0', '2018-11-13', 'Windows', 10);
INSERT INTO os_stat (seq, date, os, click) VALUES ('0', '2018-11-13', 'Ubuntu', 50);
INSERT INTO os_stat (seq, date, os, click) VALUES ('0', '2018-11-14', 'Windows', 15);
INSERT INTO os_stat (seq, date, os, click) VALUES ('0', '2018-11-14', 'Ubuntu', 1);
INSERT INTO os_stat (seq, date, os, click) VALUES ('0', '2018-11-15', 'Windows', 30);
INSERT INTO os_stat (seq, date, os, click) VALUES ('0', '2018-11-15', 'Ubuntu', 26);

INSERT INTO os_stat (seq, date, os, click) VALUES ('C', '2018-11-13', 'Windows', 1);
INSERT INTO os_stat (seq, date, os, click) VALUES ('C', '2018-11-13', 'Ubuntu', 2);
INSERT INTO os_stat (seq, date, os, click) VALUES ('C', '2018-11-14', 'Windows', 3);
INSERT INTO os_stat (seq, date, os, click) VALUES ('C', '2018-11-14', 'Ubuntu', 4);
INSERT INTO os_stat (seq, date, os, click) VALUES ('C', '2018-11-15', 'Windows', 5);
INSERT INTO os_stat (seq, date, os, click) VALUES ('C', '2018-11-15', 'Ubuntu', 6);

INSERT INTO browser_stat (seq, date, browser, click) VALUES ('C', '2018-11-13', 'Chrome', 10);
INSERT INTO browser_stat (seq, date, browser, click) VALUES ('C', '2018-11-13', 'Firefox', 50);
INSERT INTO browser_stat (seq, date, browser, click) VALUES ('C', '2018-11-14', 'Chrome', 15);
INSERT INTO browser_stat (seq, date, browser, click) VALUES ('C', '2018-11-14', 'Firefox', 1);
INSERT INTO browser_stat (seq, date, browser, click) VALUES ('C', '2018-11-15', 'Chrome', 30);
INSERT INTO browser_stat (seq, date, browser, click) VALUES ('C', '2018-11-15', 'Firefox', 26);

INSERT INTO browser_stat (seq, date, browser, click) VALUES ('0', '2018-11-13', 'Chrome', 1);
INSERT INTO browser_stat (seq, date, browser, click) VALUES ('0', '2018-11-13', 'Firefox', 2);
INSERT INTO browser_stat (seq, date, browser, click) VALUES ('0', '2018-11-14', 'Chrome', 3);
INSERT INTO browser_stat (seq, date, browser, click) VALUES ('0', '2018-11-14', 'Firefox', 4);
INSERT INTO browser_stat (seq, date, browser, click) VALUES ('0', '2018-11-15', 'Chrome', 5);
INSERT INTO browser_stat (seq, date, browser, click) VALUES ('0', '2018-11-15', 'Firefox', 6);