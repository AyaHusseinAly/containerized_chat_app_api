# README
### :paperclip: Technologies
<img src="https://user-images.githubusercontent.com/71220483/167238852-78f6a958-0037-4d08-a1a1-52f488454529.svg" width="80"/> &nbsp;  <img src="https://user-images.githubusercontent.com/71220483/167238874-e12bf41b-7ce6-4c07-a822-26d443dc3164.svg" width="40"/> &nbsp; <img src="https://user-images.githubusercontent.com/71220483/167239201-61d27b2c-5f40-4324-90f4-3d60febf6250.png" width="35"/>  &nbsp;<img src="https://user-images.githubusercontent.com/71220483/167238876-989a9725-22fc-408b-8c24-da1db41c77b1.svg" width="30"/> &nbsp;<img src="https://user-images.githubusercontent.com/71220483/167238879-df9eb29b-a6bf-4772-8b7b-83b8dff7fc22.svg" width="25"/> &nbsp;<img src="https://user-images.githubusercontent.com/71220483/167243432-517b20ca-cf11-49e6-8ab4-ddf73363737a.svg" width="65"/> &nbsp;

## :paperclip:	Get this API running through:
after cloning this repo  
1. ``` $ docker-compose build ```  
2. ``` $ docker-compose up ```  
3. ``` $ docker-compose run app rails db:migrate ```  


* Access API through:
    > http://localhost:3001  
    import <ins><i>app_chat_system_rails_5.postman_collection.json</i></ins> file from parent directory to postman desktop or check this [link](https://documenter.getpostman.com/view/12933230/UyxdKUR9) and click Run in Postman button
    
* Access database through:
    > localhost:3307  
    > Database: app  
    > User: user  
    > Password: password  

## :page_facing_up:	API documentation  
    https://documenter.getpostman.com/view/12933230/UyxdKUR9

## :pushpin:	 Create endpoints queuing system  
in order to optimize time for serving chat and messages creation requests which is considered to be many and to be served concurrently.  


1️⃣ a queuing system using <b>Redis</b> is used as temporary data store for generating the needed chat and message number for response without contacting the main database (MySQL)   


2️⃣ <b>Active Jobs</b> is used to perform saving chats and messages from the temp data in redis later after serving the request and then update Applications and Chats coulmns chat_count and message_count is performed in the background

## :paperclip: Available End-points

| Method  | URL | Request Body |
| ------- | --- | --- |
| `GET`  | /applications/:application_token/chats/:chat_number/messages| |
| `POST` | /applications/:application_token/chats/:chat_number/messages| `{"msg_body": "value"}`|
|`GET`| /applications/:application_token/chats/:chat_number/messages/:id||
|`PUT`| /applications/:application_token/chats/:chat_number/messages/:id|`{"msg_body": "value"}`|
|`GET`|/applications/:application_token/chats||
|`POST`| /applications/:application_token/chats||
|`GET`|/applications/:application_token/chats/:id||
|`GET`|/applications||
|`POST`|/applications|`{"name": "value"}`|
|`GET`|/applications/:token ||
|`PUT`|/applications/:token|`{"name": "value"}`|
|`GET`|/applications/:application_token/chats/:chat_number/search/messages?q=:query|



