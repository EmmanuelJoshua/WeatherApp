import 'package:flutter/material.dart';
import 'package:weather_app/model/citymodel.dart';
import 'package:weather_app/ui/weathercard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController cityController = new TextEditingController();

  bool isSearching = false;

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
            : TextField(
                controller: cityController,
                style: new TextStyle(
                    color: Colors.blueGrey, fontSize: 20, fontFamily: 'PTsans'),
                decoration: InputDecoration(
                  border: null,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
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
          onPressed: () {},
          icon: Icon(Icons.sort),
          color: Colors.blueGrey,
        ),
        actions: <Widget>[
          isSearching
              ? new IconButton(
                  onPressed: () {
                    setState(() {
                      this.isSearching = false;
                    });
                    String city = cityController.text;
                    CityModel().setCity(city);
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
