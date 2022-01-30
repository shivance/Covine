# Tri-NIT-Hack

## Problem Statement : ML01

Covine is an android app with 2 major features :
  ### AI based Chatbot for covid 19 assistance 
  ### Covid Alert System using Graph Colouring Algorithm
  
## TechStack : 
- Flutter & Firebase 
- Tensorflow for Natural Language Processing 
- Django for backend and REST API for communication
- 
Project Structure :

```
  ├── README.md
├── backend
│   ├── api
│   │   ├── __init__.py
│   │   ├── admin.py
│   │   ├── apps.py
│   │   ├── data.py
│   │   ├── migrations
│   │   ├── models.py
│   │   ├── nlp.py
│   │   ├── serializers.py
│   │   ├── tests.py
│   │   └── views.py
│   ├── backend
│   │   ├── __init__.py
│   │   ├── asgi.py
│   │   ├── settings.py
│   │   ├── urls.py
│   │   └── wsgi.py
│   ├── db.sqlite3
│   ├── manage.py
│   └── requirements.txt
└── covine
    ├── README.md
    ├── android
    ├── fonts
    ├── images
    ├── ios
    ├── lib
    │   ├── components
    │   │   ├── bottom_sheet_text.dart
    │   │   ├── contact_card.dart
    │   │   └── rounded_button.dart
    │   ├── constants.dart
    │   ├── main.dart
    │   └── screens
    │       ├── about.dart
    │       ├── botscreen.dart
    │       ├── login.dart
    │       ├── registration.dart
    │       ├── screen1.dart
    │       ├── screen2.dart
    │       ├── screen3.dart
    │       ├── tracing.dart
    │       └── welcome_screen.dart
    ├── pubspec.lock
    ├── pubspec.yaml
        
```

### Chatbot Info :
    We have used PreTrained Hugging face RoBERTa model and fine tuned on the covid-19 data. 
    Then we served it using REST API using Django framework , on localhost .
    Our android phone is connected to same network (we could not deploy because of storage limit in free hosting services like pythonanywhere , heroku ...)
    User sends a question string from the app interface , the backend recieves it , forward propagates it through the model , returns the response to the request...
    ...which is then displayed in the mobile

### App Info :
