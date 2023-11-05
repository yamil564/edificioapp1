import 'dart:convert';

import 'package:edificiook_app/pages/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(LoginApp());

String? username;

class LoginApp extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Edificiook',
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/usuario': (BuildContext context) => new Usuario(),
        '/LoginPage': (BuildContext context) => new LoginPage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerUser = new TextEditingController();
  TextEditingController controllerPass = new TextEditingController();

  String mensaje = '';

  Future<List> Login() async {
    final response =
        await http.post("http://192.168.0.17/edificiook/login.php", body: {
      "usu_vs_usu": controllerUser.text,
      "usu_vc_pass": controllerPass.text,
    });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        mensaje = "usuario o contraseña incorrectos";
      });
    } else {
      if (datauser[0]['usu_ch_tipoperfil'] == 'ue') {
        Navigator.pushReplacementNamed(context, '/usuario');
      } else if (datauser[0]['nivel'] == 'ua') {
        Navigator.pushReplacementNamed(context, '/usuario');
      }
      setState(() {
        username = datauser[0]['username'];
      });
    }
    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        child: Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("assets/images/edificiook.png"),
                  fit: BoxFit.cover)),
          child: Column(children: <Widget>[
            new Container(
              padding: EdgeInsets.only(top: 77.0),
              child: new CircleAvatar(
                backgroundColor: Color(0xF81F7F3),
                child: new Image(
                  width: 135,
                  height: 135,
                  image: new AssetImage('assets/images/avatar.png'),
                ),
              ),
              width: 170.0,
              height: 170.0,
              decoration: BoxDecoration(shape: BoxShape.circle),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 93),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextFormField(
                      controller: controllerUser,
                      decoration: InputDecoration(
                          icon: Icon(
                        Icons.email,
                        color: Colors.black,
                      )),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
