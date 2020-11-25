import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:ui';

const request = "https://api.github.com/users/fdAssis";

const color_Background = const Color(0xff282a36);
const color_CurrentLine = const Color(0xff44475a);
const color_Foreground = const Color(0xfff8f8f2);
const color_Green = const Color(0xff50fa7b);
const color_Red = const Color(0xffff5555);

void main() async {
  runApp(MaterialApp(home: Home()));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_Background,
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (content, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    "Carregando dados...",
                    style: TextStyle(fontSize: 25.0, color: color_Foreground),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Erro ao carregar dados...",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: color_Red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  String avatarUrl = snapshot.data["avatar_url"];
                  String name = snapshot.data['name'];
                  String bio = snapshot.data['bio'];
                  String location = snapshot.data['location'];
                  String school = snapshot.data['company'];
                  String followers = snapshot.data['followers'].toString();
                  String following = snapshot.data['following'].toString();

                  return SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(avatarUrl),
                        ),
                        Text(
                          name,
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          bio,
                          style: TextStyle(
                            fontFamily: 'Ubunto',
                            fontSize: 20.0,
                            color: Colors.teal.shade100,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 25.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.school,
                              color: Colors.teal,
                            ),
                            title: Text(
                              school,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Ubuntu',
                                color: Colors.teal.shade900,
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 25.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: Colors.teal,
                            ),
                            title: Text(
                              '+55 99 981529963',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Ubuntu',
                                color: Colors.teal.shade900,
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 25.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.email,
                              color: Colors.teal,
                            ),
                            title: Text(
                              'f.assis@acad.ifma.edu.br',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Ubuntu',
                                color: Colors.teal.shade900,
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 25.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.location_on,
                              color: Colors.teal,
                            ),
                            title: Text(
                              location,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Ubuntu',
                                color: Colors.teal.shade900,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Card(
                                color: Colors.white,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 25.0),
                                child: ListTile(
                                  title: Text(
                                    'followers: '+ followers,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.teal.shade900,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Card(
                                color: Colors.white,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 25.0),
                                child: ListTile(
                                  title: Text(
                                    'following: ' + following,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.teal.shade900,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}
