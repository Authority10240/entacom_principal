import 'package:entacomprincipal/BackEnd/Strings.dart';
import 'package:entacomprincipal/Pages/MessageMonth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:entacomprincipal/Models/MessageDate.dart';


class NotificationHome extends StatefulWidget {
  @override
  _NotificationHomeState createState() => _NotificationHomeState();
}

class _NotificationHomeState extends State<NotificationHome> {
  DatabaseReference databaseReference;
  List<MessageDate> Years ;

  @override

  Widget build(BuildContext context) {
    // TODO implement build

    if(Years == null){
      Years = new List();
      updateListView();
    }
    return
    Scaffold(

      body: ListView.builder(itemCount: Years.length,itemBuilder: (BuildContext context , int pos){
        return Card(
          color: Colors.white,
          elevation: 7.0,
          child: ListTile(
            onTap: (){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MessageMonth(Years[pos])));
            },
            leading: CircleAvatar(child: Text(Years[pos].year[2]+ Years[pos].year[3]),backgroundColor: Colors.redAccent,),
            title: Text(Years[pos].year),
            subtitle: Text('Click to enter.'),
          ),
        );
      }),
    );
  }

  updateListView(){

try {
  DatabaseReference ref = FirebaseDatabase.instance.reference().child(Strings.SCHOOL_NAME)
  .child('PRINCIPAL_APP');
  ref.onChildAdded.listen((year) {
    MessageDate date = MessageDate.values(year.snapshot.key, "", "");
    Years.add(date);
    setState(() {

    });
  });

}catch(e){
  e.toString();
}

  }


}
