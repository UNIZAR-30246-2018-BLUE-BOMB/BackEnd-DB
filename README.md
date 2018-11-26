# DB docs

## Table of content

- [Run docker-compose](#run)
- [DB info](#DBinfo)
- [Functions](#Functions)

<a name="run"></a>

## Run docker-compose
This project repository ```<repository >```
```sh
sudo apt-get install docker.io docker-compose
cd <repository>
sudo docker-compose build
sudo docker-compose up -d
```

Restarting docker
```sh
sudo docker-compose down && sudo docker-compose build && sudo docker-compose up -d
```

<a name="DBinfo"></a>

##  DB info
- Database: postgres
- User: blueBomb
- Pass: unizar

<a name="Functions"></a>

## Functions
##### new_shortened_url(url, interstitial, timeout)

|parameter|type|required|default|
|:-------:|:--:|:------:|:-----:|
|url|text|true||
|interstitial|text|false|'empty'|
|timeout|integer|false|10|

* Returns: sequence
* Return type: text

* Description

  If not exist parameters values creates new sequence and returns it.<br>
  Else if exist returns sequence of existing parameters.


##### get_supported_os()

* Returns: supported operating systems
* Return type: text[]

* Description

  Return all supported operating systems.

##### get_supported_browsers()

* Returns: supported browsers
* Return type: text[]

* Description

  Return all supported browsers.
