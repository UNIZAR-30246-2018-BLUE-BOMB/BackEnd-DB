# DB docs

## Table of content

- [Run docker-compose](#run)
- [DB info](#DBinfo)
- [Functions](#Functions)
  - [Insert new shortened url](#f-new-url)
  - [Supported OS](#f-OS)
  - [Supported browsers](#f-browsers)
  - [Add stat](#f-stat)

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

<a name="f-new-url"></a>

##### Insert new shortened url
* new_shortened_url(url, interstitial, timeout)

|parameter|type|required|default|
|:-------:|:--:|:------:|:-----:|
|url|text|true|
|interstitial|text|false|'empty'|
|timeout|integer|false|10|

* Returns: sequence
* Return type: text

* Description:

  If not exist parameters values creates new sequence and returns it.<br>
  Else if exist returns sequence of existing parameters.

<a name="f-OS"></a>

##### Supported OS

* get_supported_os()

* Returns: supported operating systems

* Return type: text[]

* Description:

  Return all supported operating systems.

<a name="f-browsers"></a>

##### Supported browsers

* get_supported_browsers()

* Returns: supported browsers

* Return type: text[]

* Description:

  Return all supported browsers.

<a name="f-stat"></a>

##### Insert stat

* insert_stat(sequence, browser, os)

|parameter|type|required|default|
|:-------:|:--:|:------:|:-----:|
|sequence|text|true|
|browser|text|true|
|os|text|true|

* Returns: nothing

* Return type: void

* Description:

  Update today stats for the browser and so given.
