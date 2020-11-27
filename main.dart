import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'feed very hungry caterpillar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    //final _scaffoldKey = GlobalKey<ScaffoldState>();
    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();  //출처: https://iosroid.tistory.com/40 [조용한 담장]
    int _counter = 10;
    Widget apple = Image.network(
      'https://i.pinimg.com/236x/c9/8e/bf/c98ebfc316ed9424e768508e0df454f5.jpg', width: 100, height: 100, fit: BoxFit.fill,  );
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (_counter >0)?Image.network(
                'https://i.etsystatic.com/9428931/r/il/d3681a/1250289452/il_570xN.1250289452_tppe.jpg',width: 300, height: 150, fit: BoxFit.fill,
            )
            :Image.network(
              'https://ak1.ostkcdn.com/images/products/9628931/The-Very-Hungry-Caterpillar-Character-Art-Caterpillar-Fat-by-Eric-Carle-6adb709d-7906-46b8-a6db-444dd85cdc82.jpg',width: 300, height: 400, fit: BoxFit.fill,
            ),
            (_counter > 0)?Text(
              'I want $_counter more apples',
              style: Theme.of(context).textTheme.headline4,
            ):
            Text(
              'I am full',
              style: Theme.of(context).textTheme.headline4,),
            Draggable (
              feedback:apple,
              child: apple,
              childWhenDragging:apple,
              //Container(width:100, height:100),

            ),
            DragTarget(builder:(context, data,rejectedData){return Container(height: 120, width: 120, color: Colors.black, );} ,
              onWillAccept: (data){ return true;},
              onAccept: (data) {

                setState
              (() {
                    _counter--;
                  });
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content:
                    (_counter > 0) ?
                    Text('I want $_counter more apples')
                        : Text('I am full')
                    ,
                    duration: Duration(seconds: 5),
                    backgroundColor: Colors.red,));
              }
            ),
          ],


        ),
      )

      );


  }
}
