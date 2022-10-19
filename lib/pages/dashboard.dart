import 'dart:convert';
import 'package:blog_post/pages/createBlog.dart';
import 'package:blog_post/pages/login.dart';
import 'package:blog_post/pages/updateBlog.dart';
import 'package:flutter/cupertino.dart';
import 'package:modals/modals.dart';
import 'package:blog_post/widgets/blog_list.dart';
import 'package:blog_post/widgets/bottombar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blog_post/widgets/blogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blog_post/widgets/blog_list.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import '../widgets/token_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String token = "";
  int id = 0;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    TokenPreference.fetchAddress('token').then((value) {
      setState(() {
        token = value!;
        print(token);
      });
    });
  }

  Future<List<Bloglist>> fetchBlogList() async {
    print("Hello");
    var jsonResponse = null;
    var response = await http.get(
      Uri.parse("https://apitest.hotelsetting.com/api/admin/blog-news"),
      headers: {
        'Authorization': 'Bearer ' + '$token',
      },
    );
    print("hello");
    print(response);
    print("hello");

    print(jsonDecode(json.encode(response.body)));
    print("hello76");
    print(response.statusCode);

    print(id);

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      var body = jsonResponse["data"]['blogs']['data'];
      print("1233");

      return body.map<Bloglist>(Bloglist.fromJson).toList();
    } else {
      throw Exception('Failed to load Blogs');
    }
  }

  deleteBlog(int id, BuildContext context) async {
    var jsonResponse = null;
    var response = await http.delete(
      Uri.parse("https://apitest.hotelsetting.com/api/admin/blog-news/delete/" +
          id.toString()),
      headers: {
        'Authorization': 'Bearer ' + '$token',
      },
    );
    jsonResponse = jsonDecode(json.encode(response.body));
    print("48");
    print(jsonResponse);
    if (response.statusCode == 200) {
      jsonResponse = jsonDecode(json.encode(response.body));
      removeAllModals();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
      return jsonResponse;
    }
    return jsonResponse;
  }

  Widget BuildDeleteAccountBtn(BuildContext context, int id) {
    return SizedBox(
      child: ElevatedButton.icon(
        onPressed: (() {
          showModal(ModalEntry.aligned(context,
              tag: 'Delete Blog',
              alignment: Alignment.center,
              child: Container(
                color: Colors.white,
                width: 300,
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    RichText(
                      text: new TextSpan(
                        text: "Are you sure you want to delete the blog ?",
                        style: GoogleFonts.abel(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child: Text(
                            "Yes",
                            style: GoogleFonts.abel(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          style:
                              TextButton.styleFrom(padding: EdgeInsets.all(15)),
                          onPressed: () {
                            deleteBlog(id, context);
                          },
                        ),
                        TextButton(
                          child: Text(
                            "No",
                            style: GoogleFonts.abel(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          style:
                              TextButton.styleFrom(padding: EdgeInsets.all(15)),
                          onPressed: () {
                            removeAllModals();
                          },
                        )
                      ],
                    )
                  ],
                ),
              )));
        }),
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            primary: Colors.black),
        icon: Icon(
          Icons.delete,
          size: 20,
        ),
        label: Text(
          "Delete Blog",
          style: GoogleFonts.abel(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }

  Widget singleBlog(int id, String categoryid, String title, String subtitle,
      String slug, String description, String date, BuildContext context) {
    return Container(
        height: 150,
        width: MediaQuery.of(context).size.width * 0.75,
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 17),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: GoogleFonts.abel(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Subtitle: " + subtitle,
                              style: GoogleFonts.abel(
                                  fontSize: 15, color: Color(0xff707070)),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UpdateBlog(
                                                  id: id,
                                                  title: title,
                                                  subtitle: subtitle,
                                                  category_id: categoryid,
                                                  slug: slug,
                                                  date: date,
                                                  description: description,
                                                )),
                                      );
                                    },
                                    label: Text(
                                      "Update Blog",
                                      style: GoogleFonts.abel(
                                          color: Color(0xffffffff),
                                          fontSize: 13),
                                    ),
                                    icon: Icon(Icons.update),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      primary: Color(0xff0057FF),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                BuildDeleteAccountBtn(context, id)
                                /*SizedBox(
                                  child: BuildDeleteAccountBtn(context),
                                )*/
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                )
              ],
            )));
  }

  Widget hero() {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder<List<Bloglist>>(
          future: fetchBlogList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final bloglists = snapshot.data;
              return Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: bloglists!.length,
                    itemBuilder: (context, index) {
                      Bloglist bloglist = bloglists[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // Widget to display the list of project
                          singleBlog(
                            bloglist.id,
                            bloglist.title,
                            bloglist.subtitle,
                            bloglist.slug,
                            bloglist.description,
                            bloglist.category_id,
                            bloglist.date,
                            context,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'BlogPost',
            style: GoogleFonts.abel(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          actions: [
            InkWell(
              child: CircleAvatar(
                backgroundImage: AssetImage('images/profilepicture.jpg'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: InkWell(
                onTap: () async {
                  var response = await http.post(
                    Uri.parse('https://apitest.hotelsetting.com/api/logout'),
                    headers: {
                      'Authorization': 'Bearer ' + '$token',
                    },
                  );
                  var jsonResponse = null;
                  jsonResponse = jsonDecode(response.body);
                  print(jsonResponse);
                  TokenPreference.saveAddress("token", "");

                  Navigator.of(context).pushAndRemoveUntil(
                    CupertinoPageRoute(builder: (context) => Login()),
                    (_) => false,
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        Icons.logout,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Container(
          height: 50,
          width: 100,
          child: Padding(
            padding: EdgeInsets.only(left: 45, bottom: 15),
            child: FloatingActionButton(
              child: Icon(
                Icons.book,
                color: Colors.white,
              ),
              backgroundColor: Color(0xff0057FF),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateBlog()),
                );
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your favourite blogs',
                    style: GoogleFonts.abel(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  hero(),
                ],
              )
            ],
          ),
        )));
  }
}
