import 'package:entacomprincipal/BackEnd/Strings.dart';
import 'package:entacomprincipal/Models/MessageDate.dart';
import 'package:entacomprincipal/Pages/MessageHome.dart';
import 'package:entacomprincipal/Pages/ViewMessage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MessageDay extends StatefulWidget {
  @override
  _MessageDayState createState() => _MessageDayState(messageDate);
  MessageDay(this.messageDate );

  MessageDate messageDate;
}

class _MessageDayState extends State<MessageDay> {
  _MessageDayState(this.messageDate);
  MessageDate messageDate;

  List<String> days;
  @override
  Widget build(BuildContext context) {

    if(days == null){
      days = List();
      updateListView();
    }
    return
      Scaffold(
        appBar: AppBar(centerTitle: true,title: Text('Message Day'),),

        body: ListView.builder(itemCount: days.length,itemBuilder: (BuildContext context , int pos){
          return Card(
            color: Colors.white,
            elevation: 7.0,
            child: ListTile(
              onTap: (){
                messageDate.day = days[pos];
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ViewMessage(messageDate)));
              },
              leading: CircleAvatar(child: Text(days[pos][0]),backgroundColor: Colors.redAccent,),
              title: Text(days[pos]),
              subtitle: Text(messageDate.year + '/' + messageDate.month),
            ),
          );
        }),
      );


  }

  updateListView(){
    DatabaseReference ref = FirebaseDatabase.instance.reference().child(Strings.SCHOOL_NAME)
        .child('PRINCIPAL_APP').child(messageDate.year).child(messageDate.month);
    ref.onChildAdded.listen((event){
      String date = event.snapshot.key;
      days.add(date);
      setState(() {

      });
    });

  }
}
