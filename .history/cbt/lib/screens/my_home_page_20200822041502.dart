// // import 'package:cbt/constants.dart';
// import 'package:cbt/services/chat_message.dart';
// import 'package:flutter/material.dart';
// import 'package:dialogflow/dialogflow.dart';
// import 'package:flutter_plugin_tts/flutter_plugin_tts.dart';
// // import 'package:tts/tts.dart';
// // // code for our homepage
// // class MyHomePage extends StatelessWidget {
// //   static const String homePageId = '/MyHomePage';

// //   // @override
// //   // Widget build(BuildContext context) {
// //   //   return Scaffold(
// //   //     body: Container(
// //   //       decoration: BoxDecoration(
// //   //         gradient: kBackgroundGradient,
// //   //       ),
// //   //       child: Center(
// //   //         child: RaisedButton(
// //   //           shape: kShapeButton,
// //   //           padding: EdgeInsets.all(0),
// //   //           onPressed: () {},
// //   //           child: Container(
// //   //             decoration: kButtonDecoration,
// //   //             padding: const EdgeInsets.all(10.0),
// //   //             child: Text(
// //   //               'Hello World',
// //   //               style: kStyleButton,
// //   //             ),
// //   //           ),
// //   //         ),
// //   //       ),
// //   //     ),
// //   //   );
// //   // }

// class MyHomePage extends StatefulWidget {
//   static const String homePageId = '/MyHomePage';

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // creating a list for chat messages
//   final List<ChatMessage> _messages = <ChatMessage>[];
//   final TextEditingController _textController = TextEditingController();

//   // building the text composer
//   Widget _buildTextComposer() {
//     return IconTheme(
//       data: IconThemeData(
//         color: Theme.of(context).accentColor,
//       ),
//       child: Container(
//         margin: EdgeInsets.symmetric(
//           horizontal: 8.0,
//         ),
//         child: Row(
//           children: <Widget>[
//             Flexible(
//               child: TextField(
//                 controller: _textController,
//                 onSubmitted: _handleSubmitted,
//                 decoration: InputDecoration.collapsed(
//                   hintText: "Write a message",
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(
//                 horizontal: 4.0,
//               ),
//               child: IconButton(
//                 icon: Icon(
//                   Icons.send,
//                 ),
//                 onPressed: () => _handleSubmitted(_textController.text),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // making a method to response for the query for the message
//   void response(query) async {
//     _textController.clear();
//     Dialogflow dialogFlow = Dialogflow(
//       token: "need to add api key here",
//     );
//     AIResponse response = await dialogFlow.sendQuery(query);
//     ChatMessage message = ChatMessage(
//       text: response.getMessageResponse(),
//       name: 'Debbie Bot',
//       type: false,
//     );
//     // Tts.speak(response.getMessageResponse());
//     // setState(() {
//     //   _messages.insert(0, message);
//     // });

//     FlutterPluginTts.speak(response.getMessageResponse());
//     setState(() {
//       _messages.insert(0, message);
//     });
//   }

//   // method for handling the submittion
//   void _handleSubmitted(String text) {
//     _textController.clear();
//     ChatMessage message = new ChatMessage(
//       text: text,
//       name: "Me",
//       type: true,
//     );
//     setState(() {
//       _messages.insert(0, message);
//     });
//     response(text);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: <Widget>[
//           Flexible(
//             child: ListView.builder(
//               itemBuilder: (_, int index) => _messages[index],
//               itemCount: _messages.length,
//               padding: EdgeInsets.all(8.0),
//               reverse: true,
//             ),
//           ),
//           Divider(
//             height: 1.0,
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: Theme.of(context).cardColor,
//             ),
//             child: _buildTextComposer(),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:cbt/services/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';

// void main() => runApp(new MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Home Page',
//       theme: new ThemeData(
//         primarySwatch: Colors.deepOrange,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: new HomePageDialogflow(),
//     );
//   }
// }

class HomePageDialogflow extends StatefulWidget {
  static const String homePageId = '/MyHomePage';

  HomePageDialogflow({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageDialogflow createState() => new _HomePageDialogflow();
}

class _HomePageDialogflow extends State<HomePageDialogflow> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  void Response(query) async {
    _textController.clear();
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/credentials.json").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(query);
    ChatMessage message = new ChatMessage(
      text: response.getMessage() ??
          new CardDialogflow(response.getListMessage()[0]).title,
      name: "Bot",
      type: false,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = new ChatMessage(
      text: text,
      name: "UserName",
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    Response(text);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Debbie"),
      ),
      body: new Column(
        children: <Widget>[
          new Flexible(
              child: new ListView.builder(
            padding: new EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length,
          )),
          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
          BottomAppBar(
            color: Colors.blue,
            child: Row(
              children: <Widget>[


                Expanded(
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: 50.0,
                    ),
                  ),
                ),



                Expanded(
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: 50.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class ChatMessage extends StatelessWidget {
//   ChatMessage({this.text, this.name, this.type});

//   final String text;
//   final String name;
//   final bool type;

//   List<Widget> otherMessage(context) {
//     return <Widget>[
//       new Container(
//         margin: const EdgeInsets.only(right: 16.0),
//         child: new CircleAvatar(child: new Text('B')),
//       ),
//       new Expanded(
//         child: new Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             new Text(this.name,
//                 style: new TextStyle(fontWeight: FontWeight.bold)),
//             new Container(
//               margin: const EdgeInsets.only(top: 5.0),
//               child: new Text(text),
//             ),
//           ],
//         ),
//       ),
//     ];
//   }

//   List<Widget> myMessage(context) {
//     return <Widget>[
//       new Expanded(
//         child: new Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: <Widget>[
//             new Text(this.name, style: Theme.of(context).textTheme.subhead),
//             new Container(
//               margin: const EdgeInsets.only(top: 5.0),
//               child: new Text(text),
//             ),
//           ],
//         ),
//       ),
//       new Container(
//         margin: const EdgeInsets.only(left: 16.0),
//         child: new CircleAvatar(
//             child: new Text(
//           this.name[0],
//           style: new TextStyle(fontWeight: FontWeight.bold),
//         )),
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//       margin: const EdgeInsets.symmetric(vertical: 10.0),
//       child: new Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: this.type ? myMessage(context) : otherMessage(context),
//       ),
//     );
//   }
// }
