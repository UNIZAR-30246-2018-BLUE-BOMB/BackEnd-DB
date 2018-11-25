create table shortened_url
(
  seq     text not null,
  url     text not null,
  add_url text    default 'empty' :: text,
  timeout integer default 10,
  constraint shortened_url_pk
  primary key (seq)
);

create unique index table_name_url_add_url_time_uindex
  on shortened_url (url, add_url, timeout);

CREATE TABLE qr
(
    seq text PRIMARY KEY,
    image bytea NOT NULL,
    CONSTRAINT qr_shortened_url_seq_fk FOREIGN KEY (seq) REFERENCES public.shortened_url (seq)
);
CREATE TABLE clickStat
(
    id bigserial PRIMARY KEY NOT NULL,
    seq text NOT NULL,
    date date NOT NULL,
    browser text NOT NULL,
    operatingSystem text NOT NULL,
    CONSTRAINT stat_shortened_url_seq_fk FOREIGN KEY (seq) REFERENCES public.shortened_url (seq)
);