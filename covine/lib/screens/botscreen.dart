import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "dart:convert";



class Bot extends StatefulWidget {
  @override
  _BotState createState() => _BotState();
}

class _BotState extends State<Bot> {
  final TextEditingController _controller = new TextEditingController();
  String res_string='';
  Future<void>postTest() async {
    
    final uri = Uri.parse("http://192.168.131.106:8000/api/bot/");
    
    final response = await http.post(
      uri,
      headers: {
        "Content-Type":"application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: {
        "qna":_controller.text.toString(),
      }
    );

    if (response.statusCode==200){
      print("Server DID NOT RETURN RESPONSE");
    }else {
      print("Server did not return 200 OK RESPONSE");
    }
    print(response.body);
    
    setState(() {
      res_string = response.body.toString();  
    });
  }
  
  
  
  @override
  void initState() {    
    super.initState();
    _controller.addListener(() {
      final String text = _controller.text.toLowerCase();
      _controller.value = _controller.value.copyWith(
        text:text,
      );
    });

    res_string = '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    
      return Scaffold(
        
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                child: TextFormField(
                  controller:_controller,
                  decoration: InputDecoration(border:OutlineInputBorder(),hintText: "Enter the question..."),
                ),
              ),
              Container(
                child:Center(
                  child:ElevatedButton(
                    child:Text("Ask Question !"),
                    onPressed: (){
                      postTest();
                      }
                    )
                )
              ),
              Text(res_string)
            ],
          ),
        ),
      );
    
  }
}