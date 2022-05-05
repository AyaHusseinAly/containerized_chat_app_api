# README

* Get this API up and running through this steps
1- clone this repo
2- docker-compose build
3- docker-compose up
4- open app terminal and run 
    > rails db:migrate

* Access App:
    > http:/localhost:3001
* Access DB:
    > connection: localhost:3307
    > User: user
    > Password: password

* Available End-points

| Method  | URL | Request Body 
| ------- | --- | --- |
| GET  | /applications/:application_token/chats/:chat_number/messages|-|
| POST | /applications/:application_token/chats/:chat_number/messages| {"msg_body": "value"}|
|GET| /applications/:application_token/chats/:chat_number/messages/:id|-|
|PUT| /applications/:application_token/chats/:chat_number/messages/:id|{"msg_body": "value"}|
|GET|/applications/:application_token/chats|-|
|POST| /applications/:application_token/chats|-|
|GET|/applications/:application_token/chats/:id|-|
|GET|/applications|-|
|POST|/applications|{"name": "value"}|
|GET|/applications/:token |-|
|PUT|/applications/:token|{"name": "value"}|
|GET|/applications/:application_token/chats//:chat_number/search/messages?q=:query|
