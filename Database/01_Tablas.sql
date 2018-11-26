create table short_sequences
(
  id       serial not null
    constraint short_sequences_pkey
    primary key,
  seq      text,
  url      text   not null,
  redirect text    default 'empty' :: text,
  time_out integer default 10
);

create unique index short_sequences_seq_uindex
  on short_sequences (seq);

create unique index short_sequences_url_redirect_time_out_uindex
  on short_sequences (url, redirect, time_out);

create table qr
(
  seq   text not null
    constraint qr_pkey
    primary key
    constraint qr_short_sequences_seq_fk
    references short_sequences (seq),
  image bytea
);

create table browser_stat
(
  seq     text not null
    constraint browser_stat_short_sequences_seq_fk
    references short_sequences (seq),
  date    date not null,
  browser text not null,
  click   integer default 0,
  constraint browser_stat_pk
  primary key (seq, date, browser)
);

create table os_stat
(
  seq   text not null
    constraint browser_stat_short_sequences_seq_fk
    references short_sequences (seq),
  date  date not null,
  os    text not null,
  click integer default 0,
  constraint os_stat_pk
  primary key (seq, date, os)
);

