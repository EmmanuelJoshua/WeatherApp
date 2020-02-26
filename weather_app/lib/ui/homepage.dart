import 'package:flutter/material.dart';
import 'package:weather_app/model/citymodel.dart';
import 'package:weather_app/ui/weathercard.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  TextEditingController cityController = new TextEditingController();

  AnimationController controller;
  bool isSearching = false;
  bool expanded = true;

  String city;

  void initState(){
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
      reverseDuration: Duration(milliseconds: 400)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? Text(
                'Weather',
                style: new TextStyle(
                    color: Colors.blueGrey, fontSize: 20, fontFamily: 'PTsans'),
              )
            : TextFormField(
                controller: cityController,
                style: new TextStyle(
                    color: Colors.blueGrey, fontSize: 20, fontFamily: 'PTsans'),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Search City Here',
                  hintStyle: new TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20,
                      fontFamily: 'PTsans'),
                ),
              ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: new IconButton(
          onPressed: () {
            setState(() {
              expanded ? controller.forward() : controller.reverse();
              expanded = !expanded;
            });
          },
          icon: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: controller),
          color: Colors.blueGrey,
        ),
        actions: <Widget>[
          isSearching
              ? new IconButton(
                  onPressed: () {
                    city = cityController.text;
                    setState(() {
//                      WeatherCardState().getWeather(city);
                      this.isSearching = false;
                    });
                  },
                  icon: Icon(Icons.check_circle),
                  color: Colors.blueGrey,
                )
              : new IconButton(
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  },
                  icon: Icon(Icons.search),
                  color: Colors.blueGrey,
                )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[

          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          new Center(
            child: Image.asset(
              'assets/images/umbrella.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          new WeatherCard(),
        ],
      ),
    );
  }
}
