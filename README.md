# README

### Get this API up and running through this steps
1. clone this repo
2. ``` $ docker-compose build ```
3. ``` $ docker-compose up ```
4. ``` $ docker-compose run app rails db:migrate ```


* Access API through:
    > http://localhost:3001  
    import <b>app_chat_system_rails_5.postman_collection.json</b> file to postman desktop or check this [link](https://documenter.getpostman.com/view/12933230/UyxdKUR9) and click Run in Postman button
    
* Access database through:
    > localhost:3307  
    > Database: app  
    > User: user  
    > Password: password  

### API documentation
https://documenter.getpostman.com/view/12933230/UyxdKUR9

##### Available End-points

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
