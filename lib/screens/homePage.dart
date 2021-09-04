import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lylac/constanats/const.dart';
import 'package:lylac/screens/mapScreen.dart';
import 'package:lylac/widgets/carouselSl.dart';
import 'package:lylac/widgets/foodItemsSl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  double latitudeData;
  double longitudeData;

  @override
  void initState() {
    super.initState();
    startTime();
    getCurrentLocation();
    getAddress();
  }
  getCurrentLocation() async {
    final geoPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitudeData = geoPosition.latitude;
      longitudeData = geoPosition.longitude;
      print('${geoPosition.latitude} ... ${geoPosition.longitude}');
    });
  }
  String city;
  String district;
  getAddress() async {
    final coordinates = new Coordinates(latitudeData, longitudeData);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      city = address.first.subLocality;
      district = address.first.locality;
    });
  }
  startTime() async {
    var _duration = new Duration(seconds: 6);
    return new Timer(_duration, () async {
      await getAddress();
      await getCurrentLocation();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        iconSize: 30,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.envelopeOpen,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event_note_rounded,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline_outlined,
            ),
            label: '',
          ),
        ],
      ),
      backgroundColor: Color(0xFFF6F6F6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 15, left: 22, right: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapScreen(
                                latitude: latitudeData,
                                longitude: longitudeData),
                          )),
                      child: Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: kThemeColor,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text('$city, $district', style: kSecondaryTextColor)
                          ],
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                          'https://www.kindpng.com/picc/m/129-1292099_black-businessman-png-cool-black-business-man-transparent.png'),
                      backgroundColor: Colors.transparent,
                    )
                  ],
                ),
                SizedBox(height: 13),
                CupertinoSearchTextField(),
                SizedBox(height: 13),
                CarouselSl(),
                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Today New Arivable', style: kPrimaryTextStyle),
                        SizedBox(height: 5),
                        Text('Best of the today  food list update',
                            style: kSecondaryTextColor),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(0xFF6B7280),
                          size: 17,
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 18),
                FoodItems(),
                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Booking Restaurant', style: kPrimaryTextStyle),
                        SizedBox(height: 5),
                        Text('Check your city Near by Restaurant',
                            style: kSecondaryTextColor),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(0xFF6B7280),
                          size: 17,
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 18),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                  height: 128,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.black,
                          image: DecorationImage(
                              image: AssetImage('assets/images/hotel.png'),
                              fit: BoxFit.fill),
                        ),
                        height: 70,
                        width: 70,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hotel Zaman Restaurant',
                            style: kPrimaryTextStyle,
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                color: kThemeColor,
                                size: 20,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text('kazi Deiry, Taiger Pass\n Chittagong',
                                  style: kSecondaryTextColor),
                              SizedBox(
                                width: 15,
                              ),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)))),
                                  onPressed: () {},
                                  child: Text('  Book  '))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
