import 'package:entacomprincipal/Models/MessageDate.dart';
import 'package:entacomprincipal/BackEnd/Strings.dart';
import 'package:entacomprincipal/Models/contact_model.dart';
import 'package:entacomprincipal/Models/message_model.dart';
import 'package:entacomprincipal/Pages/ViewSelectedTeacher.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ViewMessage extends StatefulWidget {
  @override
  _ViewMessageState createState() => _ViewMessageState(messageDate);
  MessageDate messageDate;

  ViewMessage(this.messageDate);
}

class _ViewMessageState extends State<ViewMessage> {
  List<messageInformation> messages;
  List<ContactInformation> contact;

  _ViewMessageState(this.messageDate);
  MessageDate messageDate;
  @override
  Widget build(BuildContext context) {

    if(messages == null){
      messages = new List();
      contact = new List();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text('${messageDate.year}/${messageDate.month}/${messageDate.day} Messages'),),
      body: ListView.builder(itemCount: messages.length,itemBuilder:(context,i)=>
      new Column(
        children: <Widget>[

          Card(elevation: 7,child:
          ListTile(
            subtitle: Text('${contact[i].TEACHER_NAME} \n${messages[i].SUBJECT_ID} \nGrade ${contact[i].COURSE_ID}\nSet ${contact[i].SET_ID}\n${messages[i].ARRIVAL_DATE},'),
            title: Text('${messages[i].MESSAGE_CONTENT}'),
            onTap: (){
              /*  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SubjectList(yearInfo[i])));
*/
            },
            onLongPress: (){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ViewSelected(messageDate,contact[i],messages[i])));
            },
          ) ,)

        ],
      )),

      //    body: ListView.builder(itemBuilder: null),
    );
  }
  updateListView(){
    DatabaseReference ref = FirebaseDatabase.instance.reference().child(Strings.SCHOOL_NAME)
        .child('PRINCIPAL_APP').child(messageDate.year).child(messageDate.month)
        .child(messageDate.day);

    ref.onChildAdded.listen((event){
      var data = event.snapshot.value;
      messages.add(messageInformation.fromMapObject(data["MESSAGE"]));
      contact.add(ContactInformation.fromMapObject(data['CONTACT']));
      setState(() {

      });
    });

  }
}
