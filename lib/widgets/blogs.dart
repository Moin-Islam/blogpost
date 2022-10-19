import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Blogs extends StatelessWidget {

  final String title;
  final String subtitle;
  final String slug;
  final String description;
  final String image;
  final String date;
  final String categoryId;
  final String tags;
  final Function onClick;
  

   Blogs({
    required this.title,
    required this.subtitle,
    required this.slug,
    required this.description,
    required this.date,
    required this.tags,
    required this.categoryId,
    required this.image,
    required this.onClick
   });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        
      }),
      child: Container(
        width: 160,
        height: 75,
        child: ClipRRect(  
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(image),
        ),
      ),
    );
  }
}