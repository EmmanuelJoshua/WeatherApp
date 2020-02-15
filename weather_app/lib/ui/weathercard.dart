import 'package:flutter/material.dart';
import 'package:weather_app/api/weatherapi.dart' as api;
import 'package:weather_app/api/weatherapi.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({
    Key key,
  }) : super(key: key);

  @override
  _WeatherCardState createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  String weatherImage = 'assets/images/sun.png';
  Map weather;
  List features;

  void getCatData() async {
    weather = await WeatherAPI().getWeatherData('Lagos');
    print(weather);
  }

  void initState() {
    super.initState();
    getCatData();
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
            child: updateTemp('Lagos')),
      ),
    );
  }

  FutureBuilder updateTemp(String city) {
    return FutureBuilder<Map>(
        future: WeatherAPI().getWeatherData(city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map content = snapshot.data;
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
                  Text('Check your Internet',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 21,
                          fontFamily: 'PTsans',
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ));
          }
        });
  }
}
