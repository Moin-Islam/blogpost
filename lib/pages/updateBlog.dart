import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../widgets/token_preferences.dart';

class UpdateBlog extends StatefulWidget {

  final int id ;
  final String title;
  final String subtitle;
  final String slug;
  final String description;
  final String date;
  final String category_id;
 
  const UpdateBlog({Key? key, required this.id, required this.title, required this.subtitle, required this.slug, required this.description, required this.date, required this.category_id}) : super(key: key);

  @override
  State<UpdateBlog> createState() => _UpdateBlogState();
}

class _UpdateBlogState extends State<UpdateBlog> {

   String token = "";

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
    titleController.text = widget.title;
    subtitleController.text = widget.subtitle;
    slugController.text = widget.slug;
    descriptionController.text = widget.description;
    categoryIdController.text = widget.category_id;
    dateController.text = widget.date;
    
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
                  borderSide: BorderSide(color: Color(0xff0057FF), width: 1.0))),
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
                  borderSide: BorderSide(color: Color(0xff0057FF), width: 1.0))),
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
                  borderSide: BorderSide(color: Color(0xff0057FF), width: 1.0))),
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
                  borderSide: BorderSide(color: Color(0xff0057FF), width: 1.0))),
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
                  borderSide: BorderSide(color: Color(0xff0057FF), width: 1.0))),
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
                  borderSide: BorderSide(color: Color(0xff0057FF), width: 1.0))),
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
                  borderSide: BorderSide(color: Color(0xff0057FF), width: 1.0))),
        )
      ],
    );
  }

  updateBlog(String title, String subtitle, String slug, String description, String categoryId, String date, String tags) async {

    Map data = {'title' : title,'sub_title' : subtitle, 'slug' : slug, 'description' : description, 'category_id' : categoryId, 'date' : date, 'tags' : tags};

    var jsonResponse = null;
    print(data);
    print("21");
    print(data);
    var response = await http.post(Uri.parse("https://apitest.hotelsetting.com/api/admin/blog-news/update/" + widget.id.toString()),headers : { 'Authorization' : 'Bearer ' + '$token'}, body: data);
    jsonResponse = json.decode(response.body);
    print("12");
    print(jsonResponse);

    if(response.statusCode == 200) {

      print(response.body);
      return jsonResponse;
    }
  }

  Widget buildUpdateBlogBtn() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
              onPressed:() {
                // setState(() {
                //   _isLoading = true;
                // });
                updateBlog(titleController.text, subtitleController.text,slugController.text,descriptionController.text,categoryIdController.text,dateController.text,tagsController.text)
                    .then((res) {
                  if (res["status"] == 1) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(res["message"]),
                      duration: Duration(milliseconds: 3000),
                    ));


                  }

                  // if (res.status == 0) {
                  //
                  // }
                });
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  primary: Color(0xff0057FF),
                  side: BorderSide(color: Color(0xff0057FF), width: 2)),
              child: const Text('Update Blog')),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        foregroundColor: Color(0xff1f0112),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          
        ],
      ),
      body: SingleChildScrollView(  
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1,
            vertical: 30
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Update the blog",
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
                height: 20,
              ),
              buildUpdateBlogBtn()
            ],
          ),
        ),
      ),
    );
  }
}