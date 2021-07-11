import 'package:flutter/material.dart';
import 'NotificationHome.dart';
import 'MessageHome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:entacomprincipal/BackEnd/Strings.dart';

class EntacomHome extends StatefulWidget {
  @override
  _EntacomHomeState createState() => _EntacomHomeState();
}

class _EntacomHomeState extends State<EntacomHome> with SingleTickerProviderStateMixin {
  // TODO: implement initstate
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = new TabController(vsync: this,initialIndex: 0, length: 2);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.redAccent,centerTitle: true,title: Text('${Strings.SCHOOL_NAME} Principal App ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      elevation: 7.0 ,
      bottom: new TabBar(
          controller: _tabController,
          indicatorColor: Colors.redAccent,
          tabs: <Widget>[
            new Tab(icon:  Icon(Icons.add_comment),text: "Todays Messages",),
            new Tab(icon: Icon(Icons.calendar_view_day),text: "Calendered Messages")
          ]),
      ),
      body: new TabBarView(
        controller: _tabController ,
        children: <Widget>[
          new MessageHome(),
          new NotificationHome()
        ]

      )

    );
  }


}
