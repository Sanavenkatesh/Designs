import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class DisplayImg extends StatefulWidget {
  final herotag;

  const DisplayImg({Key key, this.herotag}) : super(key: key);
  @override
  _DisplayImgState createState() => _DisplayImgState();
}

class _DisplayImgState extends State<DisplayImg> {
  @override
  Widget build(BuildContext context) {
    return Container(
          child: Hero(
          tag: widget.herotag,
            child: PhotoView(
              imageProvider: NetworkImage(widget.herotag) 
        ),
      ),
    );
  }
}
