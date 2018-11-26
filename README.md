# DB docs
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
##  DB info
- Database: postgres
- User: blueBomb
- Pass: unizar

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

  If not exist parameters values creates new sequence and returns it.
  Else if exist returns sequence of existing parameters
