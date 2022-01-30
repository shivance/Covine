import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "dart:convert";

final uri = Uri.parse("http://192.168.71.106:8000/api/bot/");

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = new TextEditingController();

  List<List<String>> chatList = [['me','hi']]; //[[user,statement],...]
  

  Widget ChatMessageList(){
    return ListView.builder(
      itemCount: chatList.length,
      itemBuilder: (context,index){
        return MessageTile(
          chatList[index][1],
          chatList[index][0]!='bot',
        );
      }
      );
  }

  String res_string='';
  Future<void>postTest() async {
    
    
    setState(() {
      chatList.add(['user',_controller.text.toString()]);
    });
    

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

    print(response.body);
    
    setState(() {
      _controller.text = "";
      res_string = response.body.toString();  
      chatList.add(['bot',res_string]);
    });
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body:Container(
        child: Stack(children: [
          ChatMessageList(),
          Container(
            alignment:Alignment.bottomCenter,
            width:MediaQuery.of(context).size.width,
            child: Container(
              color:Colors.grey,
              padding:EdgeInsets.symmetric(horizontal:24,vertical:16),
              child: Row(
                children: [
                  Expanded(child: TextField(
                    controller: _controller,
                    style: TextStyle(
                      color:Colors.white
                    ),
                    decoration: InputDecoration(
                      hintText: "Question...",
                      hintStyle: TextStyle(color:Colors.white54),
                      border:InputBorder.none
                    ),
                  ),),
                  SizedBox(width:30),
                  GestureDetector(
                    onTap:(){
                      postTest();
                    },
                    child:Container(
                      height:40,
                      width:40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          const Color(0x36FFFFFF),
                          const Color(0x0FFFFFF)
                        ]),
                        borderRadius: BorderRadius.circular(40)
                      ),
                      padding: EdgeInsets.all(12),
                      child:Image.asset("images/send.png")
                    )
                  )
                ],
              ),
            ),
          ),
        ],),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  
  MessageTile(this.message, this.sendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe
                  ? [Colors.indigo[700], Colors.indigo[700]]
                  : [Colors.indigo[100], Colors.indigo[100]],
            )),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: sendByMe ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400)),
      ),
    );
  }
}