CREATE SEQUENCE IF NOT EXISTS public.short_sequence START 63 NO MAXVALUE;
SELECT nextval('short_sequence'::regclass);

CREATE OR REPLACE FUNCTION new_shortened_url(n_head_url text, n_inter_url text default 'empty', n_timeout int default 10)
  RETURNS text
LANGUAGE plpgsql
AS $$
  DECLARE
    s_aux text = '';
    i_aux int;
    ascii_n int;
    ret text = null;
  BEGIN
    /*CREATES SEQ CODE*/
    i_aux = currval('short_sequence'::regclass);
    WHILE i_aux > 0 LOOP
      ascii_n = ascii('?') + (i_aux-1) % 62;
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
      i_aux = i_aux/62;
    END LOOP;
    /* INSERT INTO TABLE*/
    INSERT INTO shortened_url(seq, url, add_url, timeout)
    VALUES (s_aux, n_head_url, n_inter_url, n_timeout)
    ON CONFLICT DO NOTHING
    RETURNING seq INTO ret;
    IF ret IS NULL THEN
      SELECT sq.seq INTO s_aux
      FROM shortened_url sq
      WHERE sq.url = n_head_url AND sq.add_url = n_inter_url AND sq.timeout = n_timeout;
      RETURN s_aux;
    ELSE
      i_aux = nextval('short_sequence'::regclass);
      RETURN s_aux;
    END IF;
  END;
$$;