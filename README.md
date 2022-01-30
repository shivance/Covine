# Tri-NIT-Hack

## Problem Statement : ML01

Covine is an android app with 2 major features :
  ### AI based Chatbot for covid 19 assistance 
  ### Covid Alert System using Graph Colouring Algorithm
  
  
Project Structure :

  ----> Tri-NIT-Hack
  
           |_______> backend (django backend for serving the model)
            
           |_______> covine (android app client for model + Covid Alert interface)
            

### Chatbot Info :
    We have used PreTrained Hugging face RoBERTa model and fine tuned on the covid-19 data. 
    Then we served it using REST API using Django framework , on localhost .
    Our android phone is connected to same network (we could not deploy because of storage limit in free hosting services like pythonanywhere , heroku ...)
    User sends a question string from the app interface , the backend recieves it , forward propagates it through the model , returns the response to the request...
    ...which is then displayed in the mobile
