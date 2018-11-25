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