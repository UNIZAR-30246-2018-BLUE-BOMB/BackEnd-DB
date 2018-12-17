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

CREATE TYPE int_int AS (item_one int, item_two int);

CREATE TYPE text_int AS (item text, number bigint);

CREATE OR REPLACE FUNCTION get_os_global_stats(in_seq text) returns setof text_int AS $$
    SELECT os, SUM(click) FROM os_stat WHERE seq = in_seq GROUP BY seq, os;
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION get_browser_global_stats(in_seq text) returns setof text_int AS $$
    SELECT browser, SUM(click) FROM browser_stat WHERE seq = in_seq GROUP BY seq, browser;
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION insert_stat(in_seq text, in_browser text, in_os text) RETURNS TABLE(browser bigint, os bigint) AS $$
  DECLARE
    aux text;
  BEGIN
    SELECT seq INTO aux FROM short_sequences WHERE seq = in_seq;
    IF(aux IS NOT NULL) THEN
      EXECUTE insert_browser_stat(in_seq, in_browser);
      EXECUTE insert_os_stat(in_seq, in_os);
      RETURN QUERY
      SELECT b.number, o.number
      FROM get_os_global_stats(in_seq) o, get_browser_global_stats(in_seq) b
      WHERE o.item = in_os AND b.item = in_browser;
    END IF;
  END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_qr(
    in_seq text,
    in_height int,
    in_width int,
    in_err text,
    in_margin int,
    in_color int,
    in_back int,
    in_logo text,
    in_response text,
    in_qr bytea)
RETURNS BOOLEAN AS $$
  BEGIN
    INSERT INTO qr (seq, height, width, error_correction, margin, qr_color, background_color, logo, response_format, file)
    	VALUES (in_seq, in_height, in_width, in_err, in_margin, in_color, in_back, in_logo, in_response, in_qr);
    RETURN FOUND;
  END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_qr(
    in_seq text,
    in_height int,
    in_width int,
    in_err text,
    in_margin int,
    in_color int,
    in_back int,
    in_logo text,
    in_response text)
RETURNS bytea AS $$
  SELECT file
  FROM qr
  WHERE seq = in_seq
    AND height = in_height
    AND width = in_width
    AND error_correction = in_err
    AND margin = in_margin
    AND qr_color = in_color
    AND background_color = in_back
    AND logo = in_logo
    AND response_format = in_response
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_ad(in_seq text) RETURNS TABLE(ad text, t_out integer) AS $$
  DECLARE
    ad text;
  BEGIN
    SELECT redirect INTO ad FROM short_sequences WHERE seq = in_seq;
    IF(ad != 'empty') THEN
      RETURN QUERY SELECT redirect, time_out FROM short_sequences WHERE seq = in_seq;
    END IF;
  END;
  $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_head_url(in_seq text) RETURNS text AS $$
  SELECT url FROM short_sequences WHERE seq = in_seq;
  $$ LANGUAGE sql;


CREATE FUNCTION aux_os(in_seq text, in_date date) RETURNS bigint AS $$
  SELECT SUM(click) FROM os_stat WHERE seq = in_seq AND date = in_date GROUP BY date;
  $$ LANGUAGE SQL;

CREATE FUNCTION aux_browser(in_seq text, in_date date) RETURNS bigint AS $$
  SELECT SUM(click) FROM browser_stat WHERE seq = in_seq AND date = in_date GROUP BY date;
  $$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION get_os_daily_stats(in_seq text, in_from date, in_to date) RETURNS TABLE (date date, item text, click int, sum bigint) AS $$
    SELECT date, os, click, aux_os(seq, date) AS SUM
    FROM os_stat
    WHERE seq = in_seq AND
          date BETWEEN in_from AND in_to
    GROUP BY date, os, click, seq;
  $$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION get_browser_daily_stats(in_seq text, in_from date, in_to date) RETURNS TABLE (date date, item text, click int, sum bigint) AS $$
    SELECT date, browser, click, aux_browser(seq, date) AS SUM
    FROM browser_stat
    WHERE seq = in_seq AND
          date BETWEEN in_from AND in_to
    GROUP BY date, browser, click, seq;
  $$ LANGUAGE SQL;