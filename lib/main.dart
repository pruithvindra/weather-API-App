import 'dart:convert' as convert;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //     textTheme: ThemeData.light().textTheme.copyWith(
      //             title: TextStyle(
      //           fontFamily: 'Alfa',
      //           fontSize: 20,
      //         ))),
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var city;
  var weather;
  var temp;
  var humid;
  var cloud;
  var windspeed;
  var description;
  var data;
  Future weatherdata(String search) async {
    http.Response response = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?q=$search&appid=f2ef0cc9052b45c83d149c678e5a5290');

    setState(() {
      print('setstate');
      city = search;
      data = convert.jsonDecode(response.body);
      this.weather = data['weather'][0]['main'];
      this.temp = data['main']['temp'];
      this.humid = data['main']['humidity'];
      this.cloud = data['clouds']['all'];
      this.windspeed = data['wind']['speed'];
      this.description = data['weather'][0]['description'];
    });
  }

  @override
  void initState() {
    weatherdata(city);
    print('object');
    super.initState();
  }

  var date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // title: Text(
        //   'weather',
        //   style: TextStyle(
        //       fontFamily: 'Alfa',
        //       fontSize: 40,
        //       color: Colors.blue,
        //       backgroundColor: Colors.amber),
        // ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leading: GestureDetector(
        //   onTap: () => print('object'),
        //   child: Icon(
        //     Icons.search,
        //     size: 40,
        //     color: Colors.white,
        //   ),
        // ),
        actions: [
          Container(
            width: 400,
            child: TextField(
              onSubmitted: (value) => weatherdata(value),
              style: TextStyle(color: Colors.white, fontSize: 20),
              decoration: InputDecoration(
                hintText: 'search loaction',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                prefixIcon: Icon(
                  Icons.search,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:
                weather.toString() == 'Rain' || weather.toString() == 'Drizzle'
                    ? Image.asset(
                        'assets/images/rain.jpg',
                        fit: BoxFit.cover,
                      )
                    : weather.toString() == 'Clouds'
                        ? Image.asset(
                            'assets/images/clouds.jpg',
                            fit: BoxFit.cover,
                          )
                        : weather.toString() == 'Thunderstorm'
                            ? Image.asset(
                                'assets/images/thunderstorm.jpg',
                                fit: BoxFit.cover,
                              )
                            : weather.toString() == 'Snow'
                                ? Image.asset(
                                    'assets/images/snow.jpg',
                                    fit: BoxFit.cover,
                                  )
                                : weather.toString() == 'Clear'
                                    ? Image.asset(
                                        'assets/images/clearsky.jpg',
                                        fit: BoxFit.cover,
                                      )
                                    : weather.toString() == 'Mist' ||
                                            weather.toString() == 'Smoke' ||
                                            weather.toString() == 'Haze' ||
                                            weather.toString() == 'Dust' ||
                                            weather.toString() == 'FOg' ||
                                            weather.toString() == 'Sand' ||
                                            weather.toString() == 'Ash' ||
                                            weather.toString() == 'Squall' ||
                                            weather.toString() == 'Tornado'
                                        ? Image.asset(
                                            'assets/images/atmosphere.jpg',
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/images/thunderstorm.jpg',
                                            fit: BoxFit.cover,
                                          ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 1 / 10,
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(10),
                  //   child: Text(
                  //     main == null ? 'enter city ' : main,
                  //     style: TextStyle(
                  //         color: Colors.white,
                  //         fontStyle: FontStyle.italic,
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 20),
                  //   ),
                  // ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      city == null ? 'enter city ' : city,
                      style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      description != null
                          ? temp.toString() + '\u00B0'
                          : 'loading...',
                      style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 80),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      description != null
                          ? description.toString()
                          : 'loading...',
                      style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    height: MediaQuery.of(context).size.height / 2,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 30,
                            child: FaIcon(FontAwesomeIcons.temperatureHigh),
                          ),
                          title: Text(
                            'Temperature',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          trailing: Text(
                            temp != null ? temp.toString() : 'loading...',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 30,
                            child: FaIcon(FontAwesomeIcons.water),
                          ),
                          title: Text(
                            'Humidity',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          trailing: Text(
                            humid != null ? humid.toString() : 'loading...',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 30,
                            child: FaIcon(FontAwesomeIcons.wind),
                          ),
                          title: Text(
                            'Wind Speed',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          trailing: Text(
                            windspeed != null
                                ? windspeed.toString()
                                : 'loading...',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 30,
                            child: FaIcon(FontAwesomeIcons.cloud),
                          ),
                          title: Text(
                            'Clouds',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          trailing: Text(
                            cloud != null ? cloud.toString() : 'loading...',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // FloatingActionButton(onPressed: () {
                  //   Container(
                  //     padding: EdgeInsets.all(20),
                  //     width: 450,
                  //     child: TextField(
                  //       onSubmitted: (value) => weatherdata(value),
                  //       style: TextStyle(color: Colors.white, fontSize: 20),
                  //       decoration: InputDecoration(
                  //         hintText: 'search loaction',
                  //         hintStyle: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 20,
                  //         ),
                  //         prefixIcon: Icon(
                  //           Icons.search,
                  //         ),
                  //       ),
                  //     ),
                  //   );
                  // }),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
