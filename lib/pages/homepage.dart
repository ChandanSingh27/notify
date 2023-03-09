import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notify/firebase_service/notification_service.dart';
import 'package:notify/helperclass/HelperClass.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HelperClass.tabBarBackGroundColor,
          title: Text("Notify",style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 20),),
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.ellipsis_vertical))
          ],
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicator:UnderlineTabIndicator(
              borderSide: BorderSide(color: HelperClass.buttonBackgroundColor)
            ),
            tabs: const [
              Tab(icon: Icon(CupertinoIcons.chat_bubble_text_fill),child: Text("chat"),),
              Tab(icon: Icon(CupertinoIcons.bell),child: Text("Notification"),),
            ],
          ),
        ),
        body:  TabBarView(
          children: [

            Icon(Icons.abc),
            Icon(Icons.abc),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: HelperClass.buttonBackgroundColor,
        onPressed: (){},
        child: const Icon(CupertinoIcons.plus_bubble_fill,color: Colors.black,),
      ),
      ),
    );
  }
}
