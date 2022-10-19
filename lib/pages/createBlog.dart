import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:blog_post/pages/dashboard.dart';
import 'package:blog_post/widgets/token_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({Key? key}) : super(key: key);

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  bool _isLoading = false;
  late final image;
  FilePickerResult? result;
  String? filename;
  PlatformFile? pickedfile;
  bool isloading = false;
  File? filetodisplay;
  String token = "";
  late Uint8List bytes;
  late String convertedImage;

  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  TextEditingController slugController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryIdController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController tagsController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TokenPreference.fetchAddress('token').then((value) {
      setState(() {
        token = value!;
        print(token);
      });
    });
  }

  Widget buildTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Title",
          style: GoogleFonts.abel(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(
          height: 7,
        ),
        TextField(
          cursorColor: Colors.black,
          keyboardType: TextInputType.text,
          controller: titleController,
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0057FF))),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xff0057FF), width: 1.0))),
        )
      ],
    );
  }

  Widget buildSubTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sub-title",
          style: GoogleFonts.abel(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(
          height: 7,
        ),
        TextField(
          cursorColor: Colors.black,
          keyboardType: TextInputType.text,
          controller: subtitleController,
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0057FF))),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xff0057FF), width: 1.0))),
        )
      ],
    );
  }

  Widget buildSlugField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Slug",
          style: GoogleFonts.abel(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(
          height: 7,
        ),
        TextField(
          cursorColor: Colors.black,
          keyboardType: TextInputType.text,
          controller: slugController,
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0057FF))),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xff0057FF), width: 1.0))),
        )
      ],
    );
  }

  Widget buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: GoogleFonts.abel(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(
          height: 7,
        ),
        TextField(
          maxLines: null,
          cursorColor: Colors.black,
          keyboardType: TextInputType.multiline,
          controller: descriptionController,
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0057FF))),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xff0057FF), width: 1.0))),
        )
      ],
    );
  }

  Widget buildCategoryId() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Category Id",
          style: GoogleFonts.abel(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(
          height: 7,
        ),
        TextField(
          cursorColor: Colors.black,
          keyboardType: TextInputType.text,
          controller: categoryIdController,
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0057FF))),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xff0057FF), width: 1.0))),
        )
      ],
    );
  }

  Widget buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Date",
          style: GoogleFonts.abel(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(
          height: 7,
        ),
        TextField(
          cursorColor: Colors.black,
          keyboardType: TextInputType.datetime,
          controller: dateController,
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0057FF))),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xff0057FF), width: 1.0))),
        )
      ],
    );
  }

  Widget buildTagField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tag",
          style: GoogleFonts.abel(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(
          height: 7,
        ),
        TextField(
          cursorColor: Colors.black,
          keyboardType: TextInputType.text,
          controller: tagsController,
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0057FF))),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xff0057FF), width: 1.0))),
        )
      ],
    );
  }

  createBlog(String title, String subtitle, String slug, String description,
      String categoryId, String date,String image, String tags) async {
    Map data = {
      'title': title,
      'sub_title': subtitle,
      'slug': slug,
      'description': description,
      'category_id': categoryId,
      'date': date,
      'image' : image,
      'tags': tags
    };
    print(token);
    var jsonResponse = null;
    print(data);
    var response = await http.post(
        Uri.parse("https://apitest.hotelsetting.com/api/admin/blog-news/store"),
        headers: {'Authorization': 'Bearer ' + '$token'},
        body: data);
    jsonResponse = jsonDecode(response.body);
    print("hello123");
    print(jsonResponse);
    print(jsonDecode(response.body));

    if (response.statusCode == 200) {
      print(response.body);
      return (jsonResponse);
    }
  }

  Widget buildCreateBlogBtn(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
              onPressed: () {
                // setState(() {
                //   _isLoading = true;
                // });
                print('hello');
                createBlog(
                        titleController.text,
                        subtitleController.text,
                        slugController.text,
                        descriptionController.text,
                        categoryIdController.text,
                        dateController.text,
                        convertedImage,
                        tagsController.text)
                    .then((res) {
                  print("122111");
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
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  primary: Color(0xff0057FF),
                  side: BorderSide(color: Color(0xff0057FF), width: 1)),
              child: const Text('Create Blog')),
        ]);
  }

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    bytes = File(image.path).readAsBytesSync();
    String img64 = base64Encode(bytes);

    setState(() {
      convertedImage = img64;
    });
  }

  Widget buildimagePickTextButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton(
            onPressed: () {
              pickImage();
            },
            child: Text(
              "Upload Image",
              style: GoogleFonts.abel(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )),
        if (pickedfile != null)
          SizedBox(
            height: 200,
            width: 200,
            child: Image.file(filetodisplay!),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        foregroundColor: Colors.black,
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
              vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create a new blog",
                style: GoogleFonts.abel(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              buildTitleField(),
              SizedBox(
                height: 10,
              ),
              buildSubTitleField(),
              SizedBox(
                height: 10,
              ),
              buildSlugField(),
              SizedBox(
                height: 10,
              ),
              /*buildImageField(),*/
              buildDescriptionField(),
              SizedBox(
                height: 10,
              ),
              buildCategoryId(),
              SizedBox(
                height: 10,
              ),
              buildDateField(),
              SizedBox(
                height: 10,
              ),
              buildTagField(),
              SizedBox(
                height: 10,
              ),
              buildimagePickTextButton(),
              SizedBox(
                height: 20,
              ),
              buildCreateBlogBtn(context),
            ],
          ),
        ),
      ),
    );
  }
}
