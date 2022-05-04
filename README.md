# README

This README would normally document whatever steps are necessary to get the
application up and running.

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
|GET|/applications/:id |-|
|PUT|/applications/:id|{"name": "value"}|
