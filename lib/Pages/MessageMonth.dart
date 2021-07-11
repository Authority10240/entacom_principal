import 'package:entacomprincipal/BackEnd/Strings.dart';
import 'package:entacomprincipal/Models/MessageDate.dart';
import 'package:entacomprincipal/Models/MonthsObject.dart';
import 'package:entacomprincipal/Pages/MessageDay.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MessageMonth extends StatefulWidget {
  @override
  MessageDate messageDate;
  MessageMonth(this.messageDate);
  _MessageMonthState createState() => _MessageMonthState(messageDate);

}

class _MessageMonthState extends State<MessageMonth> {
  MessageDate messageDate;
    _MessageMonthState(this.messageDate);
    List<String> months;
  @override


  Widget build(BuildContext context) {
    if(months == null) {
      months = List();
      updateListVIew();
    }
   return Scaffold(
     appBar: AppBar(backgroundColor: Colors.redAccent,title: Text('Message Month'),centerTitle: true,),

      body: ListView.builder(itemCount: months.length,itemBuilder: (BuildContext context , int pos){
        return Card(
          color: Colors.white,
          elevation: 7.0,
          child: ListTile(
            onTap: (){
              messageDate.month = months[pos];
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MessageDay(messageDate)));
            },
            leading: CircleAvatar(child: Text(months[pos][0]), backgroundColor: Colors.redAccent,),
            title: Text(monthObject(months[pos]).getMonthName(), style: TextStyle(color: Colors.black),),
            subtitle: Text(messageDate.year),
          ),
        );
      }),
    );
  }
   updateListVIew(){
    DatabaseReference ref = FirebaseDatabase.instance.reference().child(Strings.SCHOOL_NAME)
        .child('PRINCIPAL_APP').child(messageDate.year);
    ref.onChildAdded.listen((month){
    monthObject monthsobj = monthObject(month.snapshot.key);


      months.add(monthsobj.monthNumber);
      setState(() {

      });
    });
   }

}
