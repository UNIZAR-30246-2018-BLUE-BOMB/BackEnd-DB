SELECT new_shortened_url('https://www.google.es/');
SELECT new_shortened_url('https://www.google.es/', 'http://unizar.es/');
SELECT new_shortened_url('https://www.google.es/', 'http://unizar.es/', 15);
SELECT new_shortened_url('https://www.google.es/', 'https://github.com/orgs/UNIZAR-30246-2018-BLUE-BOMB/dashboard');
SELECT new_shortened_url('https://github.com/orgs/UNIZAR-30246-2018-BLUE-BOMB/dashboard', 'https://www.google.es/');

INSERT INTO os_stat (seq, date, os, click) VALUES ('0', '2018-11-13', 'windows', 10);
INSERT INTO os_stat (seq, date, os, click) VALUES ('0', '2018-11-13', 'ubuntu', 50);
INSERT INTO os_stat (seq, date, os, click) VALUES ('0', '2018-11-14', 'windows', 15);
INSERT INTO os_stat (seq, date, os, click) VALUES ('0', '2018-11-14', 'ubuntu', 1);
INSERT INTO os_stat (seq, date, os, click) VALUES ('0', '2018-11-15', 'windows', 30);
INSERT INTO os_stat (seq, date, os, click) VALUES ('0', '2018-11-15', 'ubuntu', 26);

INSERT INTO os_stat (seq, date, os, click) VALUES ('C', '2018-11-13', 'windows', 1);
INSERT INTO os_stat (seq, date, os, click) VALUES ('C', '2018-11-13', 'ubuntu', 2);
INSERT INTO os_stat (seq, date, os, click) VALUES ('C', '2018-11-14', 'windows', 3);
INSERT INTO os_stat (seq, date, os, click) VALUES ('C', '2018-11-14', 'ubuntu', 4);
INSERT INTO os_stat (seq, date, os, click) VALUES ('C', '2018-11-15', 'windows', 5);
INSERT INTO os_stat (seq, date, os, click) VALUES ('C', '2018-11-15', 'ubuntu', 6);

INSERT INTO browser_stat (seq, date, browser, click) VALUES ('C', '2018-11-13', 'chrome', 10);
INSERT INTO browser_stat (seq, date, browser, click) VALUES ('C', '2018-11-13', 'firefox', 50);
INSERT INTO browser_stat (seq, date, browser, click) VALUES ('C', '2018-11-14', 'chrome', 15);
INSERT INTO browser_stat (seq, date, browser, click) VALUES ('C', '2018-11-14', 'firefox', 1);
INSERT INTO browser_stat (seq, date, browser, click) VALUES ('C', '2018-11-15', 'chrome', 30);
INSERT INTO browser_stat (seq, date, browser, click) VALUES ('C', '2018-11-15', 'firefox', 26);

INSERT INTO browser_stat (seq, date, browser, click) VALUES ('0', '2018-11-13', 'chrome', 1);
INSERT INTO browser_stat (seq, date, browser, click) VALUES ('0', '2018-11-13', 'firefox', 2);
INSERT INTO browser_stat (seq, date, browser, click) VALUES ('0', '2018-11-14', 'chrome', 3);
INSERT INTO browser_stat (seq, date, browser, click) VALUES ('0', '2018-11-14', 'firefox', 4);
INSERT INTO browser_stat (seq, date, browser, click) VALUES ('0', '2018-11-15', 'chrome', 5);
INSERT INTO browser_stat (seq, date, browser, click) VALUES ('0', '2018-11-15', 'firefox', 6);