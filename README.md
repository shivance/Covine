# Tri-NIT-Hack

## Problem Statement : ML01

Covine is an android app with 2 major features :
  ### AI based Chatbot for covid 19 assistance 
  ### Covid Alert System using Graph Colouring Algorithm
  
  
Project Structure :

  ----
  ├── README.md
├── backend
│   ├── api
│   │   ├── __init__.py
│   │   ├── __pycache__
│   │   │   ├── __init__.cpython-39.pyc
│   │   │   ├── admin.cpython-39.pyc
│   │   │   ├── apps.cpython-39.pyc
│   │   │   ├── data.cpython-39.pyc
│   │   │   ├── models.cpython-39.pyc
│   │   │   ├── nlp.cpython-39.pyc
│   │   │   ├── serializers.cpython-39.pyc
│   │   │   ├── urls.cpython-39.pyc
│   │   │   └── views.cpython-39.pyc
│   │   ├── admin.py
│   │   ├── apps.py
│   │   ├── data.py
│   │   ├── migrations
│   │   │   ├── 0001_initial.py
│   │   │   ├── 0002_rename_qnamodel_qna.py
│   │   │   ├── __init__.py
│   │   │   └── __pycache__
│   │   │       ├── 0001_initial.cpython-39.pyc
│   │   │       ├── 0002_rename_qnamodel_qna.cpython-39.pyc
│   │   │       └── __init__.cpython-39.pyc
│   │   ├── models.py
│   │   ├── nlp.py
│   │   ├── serializers.py
│   │   ├── tests.py
│   │   └── views.py
│   ├── backend
│   │   ├── __init__.py
│   │   ├── __pycache__
│   │   │   ├── __init__.cpython-39.pyc
│   │   │   ├── settings.cpython-39.pyc
│   │   │   ├── urls.cpython-39.pyc
│   │   │   └── wsgi.cpython-39.pyc
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
    │   ├── app
    │   │   ├── build.gradle
    │   │   ├── google-services.json
    │   │   └── src
    │   │       ├── debug
    │   │       │   └── AndroidManifest.xml
    │   │       ├── main
    │   │       │   ├── AndroidManifest.xml
    │   │       │   ├── kotlin
    │   │       │   │   └── com
    │   │       │   │       └── example
    │   │       │   │           └── tracov
    │   │       │   │               └── MainActivity.kt
    │   │       │   └── res
    │   │       │       ├── drawable
    │   │       │       │   └── launch_background.xml
    │   │       │       ├── mipmap-hdpi
    │   │       │       │   └── ic_launcher.png
    │   │       │       ├── mipmap-mdpi
    │   │       │       │   └── ic_launcher.png
    │   │       │       ├── mipmap-xhdpi
    │   │       │       │   └── ic_launcher.png
    │   │       │       ├── mipmap-xxhdpi
    │   │       │       │   └── ic_launcher.png
    │   │       │       ├── mipmap-xxxhdpi
    │   │       │       │   └── ic_launcher.png
    │   │       │       └── values
    │   │       │           └── styles.xml
    │   │       └── profile
    │   │           └── AndroidManifest.xml
    │   ├── build.gradle
    │   ├── gradle
    │   │   └── wrapper
    │   │       └── gradle-wrapper.properties
    │   ├── gradle.properties
    │   └── settings.gradle
    ├── fonts
    │   ├── Exo.ttf
    │   ├── Montserrat-Bold.ttf
    │   └── Montserrat-Regular.ttf
    ├── images
    │   ├── addingNodes.gif
    │   ├── anim.gif
    │   ├── bg1.jpeg
    │   ├── bg1.jpg
    │   ├── corona.jpeg
    │   ├── corona.png
    │   ├── profile1.jpg
    │   ├── profile_pic.jpeg
    │   ├── tracovGIF.gif
    │   ├── user.jpg
    │   └── user.png
    ├── ios
    │   ├── Flutter
    │   │   ├── AppFrameworkInfo.plist
    │   │   ├── Debug.xcconfig
    │   │   └── Release.xcconfig
    │   ├── Runner
    │   │   ├── AppDelegate.swift
    │   │   ├── Assets.xcassets
    │   │   │   ├── AppIcon.appiconset
    │   │   │   │   ├── Contents.json
    │   │   │   │   ├── Icon-App-1024x1024@1x.png
    │   │   │   │   ├── Icon-App-20x20@1x.png
    │   │   │   │   ├── Icon-App-20x20@2x.png
    │   │   │   │   ├── Icon-App-20x20@3x.png
    │   │   │   │   ├── Icon-App-29x29@1x.png
    │   │   │   │   ├── Icon-App-29x29@2x.png
    │   │   │   │   ├── Icon-App-29x29@3x.png
    │   │   │   │   ├── Icon-App-40x40@1x.png
    │   │   │   │   ├── Icon-App-40x40@2x.png
    │   │   │   │   ├── Icon-App-40x40@3x.png
    │   │   │   │   ├── Icon-App-60x60@2x.png
    │   │   │   │   ├── Icon-App-60x60@3x.png
    │   │   │   │   ├── Icon-App-76x76@1x.png
    │   │   │   │   ├── Icon-App-76x76@2x.png
    │   │   │   │   └── Icon-App-83.5x83.5@2x.png
    │   │   │   └── LaunchImage.imageset
    │   │   │       ├── Contents.json
    │   │   │       ├── LaunchImage.png
    │   │   │       ├── LaunchImage@2x.png
    │   │   │       ├── LaunchImage@3x.png
    │   │   │       └── README.md
    │   │   ├── Base.lproj
    │   │   │   ├── LaunchScreen.storyboard
    │   │   │   └── Main.storyboard
    │   │   ├── Info.plist
    │   │   └── Runner-Bridging-Header.h
    │   ├── Runner.xcodeproj
    │   │   ├── project.pbxproj
    │   │   ├── project.xcworkspace
    │   │   │   ├── contents.xcworkspacedata
    │   │   │   └── xcshareddata
    │   │   │       ├── IDEWorkspaceChecks.plist
    │   │   │       └── WorkspaceSettings.xcsettings
    │   │   └── xcshareddata
    │   │       └── xcschemes
    │   │           └── Runner.xcscheme
    │   └── Runner.xcworkspace
    │       ├── contents.xcworkspacedata
    │       └── xcshareddata
    │           ├── IDEWorkspaceChecks.plist
    │           └── WorkspaceSettings.xcsettings
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
    └── test
        └── widget_test.dart
        
            

### Chatbot Info :
    We have used PreTrained Hugging face RoBERTa model and fine tuned on the covid-19 data. 
    Then we served it using REST API using Django framework , on localhost .
    Our android phone is connected to same network (we could not deploy because of storage limit in free hosting services like pythonanywhere , heroku ...)
    User sends a question string from the app interface , the backend recieves it , forward propagates it through the model , returns the response to the request...
    ...which is then displayed in the mobile
