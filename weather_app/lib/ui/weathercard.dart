import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_app/api/weatherapi.dart';
import 'package:weather_app/model/citymodel.dart';
import 'package:weather_app/ui/homepage.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({
    Key key,
  }) : super(key: key);

  @override
  WeatherCardState createState() => WeatherCardState();
}

class WeatherCardState extends State<WeatherCard> {
  String weatherImage = 'assets/images/sun.png';
  Map weather;
  List features;
  String defaultCity = 'Seattle';
  String cityEntered;

  Future<Map> weatherFuture;

  Future<Map> getWeather() async {
    if(HomePageState().city == null){
      weatherFuture = WeatherAPI().getWeatherData(defaultCity);
      debugPrint('Called Again: ${HomePageState().city}');
    }else if(HomePageState().city != null){
      weatherFuture = WeatherAPI().getWeatherData(HomePageState().city);
      debugPrint('Called Again: ${HomePageState().city}');
    }
    return await weatherFuture;
  }

  void initState() {
    super.initState();
//    weatherFuture = getWeather(cityEntered);
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: SizedBox(
        width: 250,
        height: 300,
        child: Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: Colors.white,
            child: updateTemp()),
      ),
    );
  }

  FutureBuilder updateTemp() {
    return FutureBuilder<Map>(
        future: getWeather(),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map content = snapshot.data;
            if (content['weather'][0]['main'].toString() == 'Haze' ||
                content['weather'][0]['main'].toString() == 'Clear' ||
                content['weather'][0]['main'].toString() == 'Sunny') {
              weatherImage = 'assets/images/sun.png';
            } else if (content['weather'][0]['main'].toString() == 'Clouds') {
              weatherImage = 'assets/images/cloud.png';
            } else if (content['weather'][0]['main'].toString() == 'Rain') {
              weatherImage = 'assets/images/rain.png';
            } else if (content['weather'][0]['main'].toString() == 'Snow') {
              weatherImage = 'assets/images/snow.png';
            } else if (content['weather'][0]['main'].toString() == 'Thunder') {
              weatherImage = 'assets/images/thunder.png';
            }
            return Column(
              children: [
                SizedBox(
                  width: 249,
                  height: 200,
                  child: new Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(left: 20, top: 15),
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                '$weatherImage',
                                height: 60,
                                width: 60,
                              ),
                              Container(
                                  margin:
                                      const EdgeInsets.only(top: 14, left: 10),
                                  child: RichText(
                                    text: TextSpan(text: '', children: [
                                      new TextSpan(children: [
                                        TextSpan(
                                            text:
                                                '${content['weather'][0]['main']}\n',
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 15,
                                                fontFamily: 'PTsans',
                                                height: 0.1,
                                                fontWeight: FontWeight.w500)),
                                        TextSpan(
                                            text:
                                                '${content['main']['temp'].toString()}C',
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 35,
                                                fontFamily: 'Abel',
                                                fontWeight: FontWeight.w500)),
                                      ])
                                    ]),
                                  )),
                            ],
                          ),
                        ),
                        new Divider(
                          color: Colors.blueGrey.withOpacity(0.3),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(top: 40),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(text: '', children: [
                                        new TextSpan(children: [
                                          TextSpan(
                                              text: 'Humidity\n',
                                              style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 15,
                                                  fontFamily: 'PTsans',
                                                  height: 0.1,
                                                  fontWeight: FontWeight.w500)),
                                          TextSpan(
                                              text:
                                                  '${content['main']['humidity'].toString()}C',
                                              style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 35,
                                                  fontFamily: 'Abel',
                                                  fontWeight: FontWeight.w500)),
                                        ])
                                      ]),
                                    ),
                                    RichText(
                                      text: TextSpan(text: '', children: [
                                        new TextSpan(children: [
                                          TextSpan(
                                              text: 'Pressure\n',
                                              style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 15,
                                                  fontFamily: 'PTsans',
                                                  height: 0.1,
                                                  fontWeight: FontWeight.w500)),
                                          TextSpan(
                                              text:
                                                  '${content['main']['pressure'].toString()}P',
                                              style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 35,
                                                  fontFamily: 'Abel',
                                                  fontWeight: FontWeight.w500)),
                                        ])
                                      ]),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                new Divider(
                  color: Colors.blueGrey.withOpacity(0.3),
                ),
                ListTile(
                  title: Text('${content['name']}',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 21,
                          fontFamily: 'PTsans',
                          fontWeight: FontWeight.w500)),
                  subtitle: Text(
                      '${content['weather'][0]['description'].toString().toUpperCase()}',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15,
                          fontFamily: 'PTsans',
                          fontWeight: FontWeight.w100)),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.location_on,
                    ),
                    color: Colors.blueGrey,
                    iconSize: 34,
                  ),
                ),
              ],
            );
          } else {
            return Center(
                child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/wifi.png',
                    height: 90,
                    width: 90,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text('Check your Internet',
                        style: TextStyle(
                            color: Color(0xFF4CAEFE),
                            fontSize: 21,
                            fontFamily: 'PTsans',
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ));
          }
        });
  }
}
