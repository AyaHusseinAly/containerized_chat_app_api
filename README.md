# README

This README would normally document whatever steps are necessary to get the
application up and running.

* Available End-points

| Method  | URL | Action| Request Body 
| ------- | --- | --- | --- |
| GET  | /applications/:application_token/chats/:chat_number/messages|list chat messages|-|
| POST | /applications/:application_token/chats/:chat_number/messages|create chat message| {"msg_body": "value"}|
|GET| /applications/:application_token/chats/:chat_number/messages/:id|show chat message details|-|
|PUT| /applications/:application_token/chats/:chat_number/messages/:id|update chat message details|{"msg_body": "value"}|
|GET|/applications/:application_token/chats|list application chats|-|
|POST| /applications/:application_token/chats|create application chat|-|
|GET|/applications/:application_token/chats/:id|show application chat details|-|
|GET|/applications|list applications|-|
|POST|/applications|create application|{"name": "value"}|
|GET|/applications/:id |show application details|-|
|PUT|/applications/:id|update application details|{"name": "value"}|
