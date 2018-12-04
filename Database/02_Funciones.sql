CREATE OR REPLACE FUNCTION convert_to_sequence(value bigint) returns text as $$
  DECLARE
    s_aux text = '';
    ascii_n int;
  BEGIN
    WHILE value > 0 LOOP
      ascii_n = ascii('?') + (value-1) % 62;
      CASE
        WHEN ascii_n=63 THEN s_aux = '0' || s_aux;
        WHEN ascii_n=64 THEN s_aux = '1' || s_aux;
        WHEN ascii_n=91 THEN s_aux = '2' || s_aux;
        WHEN ascii_n=92 THEN s_aux = '3' || s_aux;
        WHEN ascii_n=93 THEN s_aux = '4' || s_aux;
        WHEN ascii_n=94 THEN s_aux = '5' || s_aux;
        WHEN ascii_n=95 THEN s_aux = '6' || s_aux;
        WHEN ascii_n=96 THEN s_aux = '7' || s_aux;
        WHEN ascii_n=123 THEN s_aux = '8' || s_aux;
        WHEN ascii_n=124 THEN s_aux = '9' || s_aux;
        ELSE s_aux = text(CHR(ascii_n)) || s_aux;
      END CASE;
      value = value/62;
    END LOOP;
    return s_aux;
  end;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION new_shortened_url(n_head_url text, n_inter_url text default 'empty', n_timeout int default 10)
  RETURNS text
AS $$
  DECLARE
    aux int = 0;
    retVal text = 'fail';
  BEGIN
    /* INSERT INTO TABLE*/
    SELECT seq, id INTO retVal, aux
    FROM short_sequences
    WHERE url = n_head_url AND
            redirect = n_inter_url AND
            time_out = n_timeout;
    IF(aux IS NULL) THEN
      INSERT INTO short_sequences(url, redirect, time_out)
      VALUES (n_head_url, n_inter_url, n_timeout)
      RETURNING id INTO aux;
      UPDATE short_sequences SET seq = convert_to_sequence(aux) WHERE id = aux RETURNING seq into retVal;
    END IF;
    RETURN retVal;
  END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_supported_os() RETURNS SETOF text AS $$
  SELECT DISTINCT os
  FROM os_stat
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_supported_browsers() RETURNS SETOF text AS $$
  SELECT DISTINCT browser
  FROM browser_stat
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION insert_browser_stat(in_seq text, in_browser text) RETURNS void AS $$
  DECLARE
    aux text;
    clicks int;
  BEGIN
    SELECT seq, click INTO aux, clicks
    FROM browser_stat
    WHERE seq = in_seq
      AND date = current_date
      AND browser = in_browser;
    IF(aux IS NULL) THEN
      INSERT INTO browser_stat(seq, date, browser, click)
      VALUES (in_seq, current_date, in_browser, 1);
    ELSE
      UPDATE browser_stat
      SET click = clicks + 1
      WHERE seq = in_seq
        AND date = current_date
        AND browser = in_browser;
    END IF;
  END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_os_stat(in_seq text, in_os text) RETURNS void AS $$
  DECLARE
    aux text;
    clicks int;
  BEGIN
    SELECT seq, click INTO aux, clicks
    FROM os_stat
    WHERE seq = in_seq
      AND date = current_date
      AND os = in_os;
    IF(aux IS NULL) THEN
      INSERT INTO os_stat(seq, date, os, click)
      VALUES (in_seq, current_date, in_os, 1);
    ELSE
      UPDATE os_stat
      SET click = clicks + 1
      WHERE seq = in_seq
        AND date = current_date
        AND os = in_os;
    END IF;
  END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_stat(in_seq text, in_browser text, in_os text) RETURNS VOID AS $$
  BEGIN
    EXECUTE insert_browser_stat(in_seq, in_browser);
    EXECUTE insert_os_stat(in_seq, in_os);
  END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_qr(in_seq text, in_qr bytea) RETURNS BOOLEAN AS $$
  DECLARE
    aux text;
  BEGIN
    SELECT seq INTO aux FROM qr WHERE seq = in_seq;
    IF(aux IS NULL) THEN
      UPDATE qr SET image = in_qr WHERE seq = in_seq;
      RETURN FOUND;
    ELSE
      INSERT INTO qr(seq, image) VALUES (in_seq, in_qr);
      RETURN FOUND;
    END IF;
  END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_qr(in_seq text) RETURNS bytea AS $$
  SELECT image
  FROM qr
  WHERE seq = in_seq
$$ LANGUAGE sql;

CREATE TYPE text_int AS (item text, number bigint);

CREATE OR REPLACE FUNCTION get_os_global_stats(in_seq text) returns setof text_int AS $$
    SELECT os, SUM(click) FROM os_stat WHERE seq = in_seq GROUP BY seq, os;
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION get_browser_global_stats(in_seq text) returns setof text_int AS $$
    SELECT browser, SUM(click) FROM browser_stat WHERE seq = in_seq GROUP BY seq, browser;
$$ LANGUAGE SQL;