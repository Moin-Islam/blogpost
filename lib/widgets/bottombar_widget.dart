import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
      child: BottomAppBar(  
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(  
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 50,
                children: [
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: Icon(
                      Icons.home ,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: Icon(
                      Icons.favorite_outline
                    ),
                  )
                ],
              ),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 55,
                children: [
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: Icon(
                      Icons.update ,
                      
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: Icon(
                      Icons.delete
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}