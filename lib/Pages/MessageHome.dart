import 'package:entacomprincipal/BackEnd/Strings.dart';
import 'package:entacomprincipal/Models/contact_model.dart';
import 'package:entacomprincipal/Models/message_model.dart';
import 'package:firebase_database/firebase_database.dart';
import'package:flutter/material.dart';


    
    class MessageHome extends StatefulWidget {
      @override
      _MessageHomeState createState() => _MessageHomeState();
    }
    
    class _MessageHomeState extends State<MessageHome> {
      List<messageInformation> messages;
      List<ContactInformation> contact;
      @override
      Widget build(BuildContext context) {

        if(messages == null){
          messages = new List();
          contact = new List();
          updateListView();
        }
        return Scaffold(

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
              ) ,)

            ],
          )),
          
      //    body: ListView.builder(itemBuilder: null),
        );
      }

      updateListView(){
        DatabaseReference ref = FirebaseDatabase.instance.reference().child(Strings.SCHOOL_NAME)
            .child('PRINCIPAL_APP').child(DateTime.now().year.toString()).child(DateTime.now().month.toString())
            .child(DateTime.now().day.toString());

        ref.onChildAdded.listen((event){
          var data = event.snapshot.value;
          messages.add(messageInformation.fromMapObject(data["MESSAGE"]));
          contact.add(ContactInformation.fromMapObject(data['CONTACT']));
          setState(() {

          });
        });

      }
    }
    