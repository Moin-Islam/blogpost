import 'dart:convert';

import 'package:blog_post/pages/createBlog.dart';
import 'package:blog_post/pages/dashboard.dart';
import 'package:blog_post/widgets/token_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  var token = "";

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signIn(String email, pass) async {
    setState(() {
      _isLoading = true;
    });

    Map data = {'email': email, 'password': pass};

    var jsonResponse = null;
    var response = await http.post(
        Uri.parse("https://apitest.hotelsetting.com/api/login"),
        body: data);
    jsonResponse = json.decode(response.body);

    print(jsonResponse);

    if (response.statusCode == 200) {
      print(response.body);

      if (jsonResponse != null) {
        print(response.body);
        var token;
        TokenPreference.saveAddress("token", jsonResponse["data"]["token"]);
        final prefs = await SharedPreferences.getInstance();
        token = prefs.getString("token");

        print(token);
      }
    } else {
      print(response.body);
      return jsonResponse;
    }

    return jsonResponse;
  }

  Widget buildShowLogo() {
    return SizedBox(
      height: 200,
      width: 300,
      child: Image(image: AssetImage('images/logo.png')),
    );
  }

  Widget buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: GoogleFonts.abel(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(
          height: 7,
        ),
        TextField(
          cursorColor: Colors.black,
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: GoogleFonts.teko(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0057FF))),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xff0057FF), width: 1.0))),
        )
      ],
    );
  }

  Widget buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Password",
          style: GoogleFonts.abel(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(
          height: 7,
        ),
        TextField(
          cursorColor: Colors.black,
          obscureText: true,
          keyboardType: TextInputType.text,
          controller: passwordController,
          decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: GoogleFonts.teko(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0057FF))),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xff0057FF), width: 1.0))),
        )
      ],
    );
  }

  Widget buildLoginBtn() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
              onPressed: () {
                // setState(() {
                //   _isLoading = true;
                // });
                signIn(emailController.text, passwordController.text)
                    .then((res) {
                  if (res["status"] == 1) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(res["message"]),
                      duration: Duration(milliseconds: 3000),
                    ));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Dashboard()),
                    );
                  }

                  // if (res.status == 0) {
                  //
                  // }
                });
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  primary: Color(0xff0057FF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  side: BorderSide(color: Colors.white, width: 1)),
              child: const Text('Login')),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
              vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildShowLogo(),
              SizedBox(
                height: 15,
              ),
              Text(
                "Welcome Back",
                style: GoogleFonts.abel(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Log in to your account",
                style: GoogleFonts.teko(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 15,
              ),
              buildEmailField(),
              SizedBox(
                height: 15,
              ),
              buildPasswordField(),
              SizedBox(
                height: 30,
              ),
              buildLoginBtn()
            ],
          ),
        ),
      ),
    );
  }
}
