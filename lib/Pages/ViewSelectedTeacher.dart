import 'package:entacomprincipal/Models/MessageDate.dart';
import 'package:entacomprincipal/BackEnd/Strings.dart';
import 'package:entacomprincipal/Models/contact_model.dart';
import 'package:entacomprincipal/Models/message_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ViewSelected extends StatefulWidget {
  @override
  _ViewSelectedState createState() => _ViewSelectedState(messageDate,contactInformation,messageInform);
  MessageDate messageDate;
  ContactInformation contactInformation;
  messageInformation messageInform;

  ViewSelected(this.messageDate, this.contactInformation, this.messageInform);
}

class _ViewSelectedState extends State<ViewSelected> {
  List<messageInformation> messages;
  List<ContactInformation> contact;

  _ViewSelectedState(this.messageDate, this.contactInformation, this.messageInform);
  MessageDate messageDate;
  ContactInformation contactInformation;
  messageInformation messageInform;
  @override
  Widget build(BuildContext context) {

    if(messages == null){
      messages = new List();
      contact = new List();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text('${contactInformation.TEACHER_NAME}\'s ${messageInform.SUBJECT_ID} Messages'),),
      body: ListView.builder(itemCount: messages.length,itemBuilder:(context,i)=>
      new Column(
        children: <Widget>[

          Card(elevation: 7,child:
          ListTile(
            subtitle: Text('${contactInformation.TEACHER_NAME} \n${messages[i].SUBJECT_ID} \nGrade ${contactInformation.COURSE_ID}\nSet ${contactInformation.SET_ID}\n${messages[i].ARRIVAL_DATE},'),
            title: Text('${messages[i].MESSAGE_CONTENT}'),
            onTap: (){
              /*  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SubjectList(yearInfo[i])));
*/
            },
          ) ,)

        ],
      )),

      //    body: ListView.builder(itemBuilder: null),
    );
  }
  updateListView(){
    DatabaseReference ref = FirebaseDatabase.instance.reference().child(Strings.SCHOOL_NAME)
        .child('SMESSAGES').child(contactInformation.TEACHER_ID).child(messageDate.year)
        .child(contactInformation.COURSE_ID).child(contactInformation.SUBJECT_ID)
    .child(contactInformation.SET_ID).child('GROUPED');

    ref.onChildAdded.listen((event){
      var data = event.snapshot.value;
      messages.add(messageInformation.fromMapObject(data));
      setState(() {

      });
    });

  }
}
