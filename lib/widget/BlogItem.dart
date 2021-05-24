import 'dart:io';

import '../providers/blog.dart';
import '../providers/selected.dart';
import '../screens/HomeScreen.dart';
import 'package:provider/provider.dart';

import '../screens/blogDetails.dart';
import '../screens/createBlog.dart';
import 'package:flutter/material.dart';
import '../constants/Theme.dart';
import 'package:share/share.dart';
import 'popup.dart';

class BlogItem extends StatefulWidget {
  final int id;
  final String title;
  final String body;
  final String date;
  final String image;
  const BlogItem(
    this.id,
    this.title,
    this.body,
    this.date,
    this.image,
  );

  @override
  _BlogItemState createState() => _BlogItemState();
}

class _BlogItemState extends State<BlogItem> {
  bool isSelected = false;

  Widget build(BuildContext context) {
    bool isnull = true;
    if (widget.image == null || widget.image == '') {
      isnull = false;
    }

    var selected = Provider.of<SelectedItems>(context).selectedBlogs;
    setState(() {
      if (selected != null && selected.contains(widget.id)) {
        isSelected = true;
      } else {
        isSelected = false;
      }
    });
    select() {
      print('Selected ' + widget.id.toString());
      if (selected.contains(widget.id)) {
        isSelected = false;
        print('Deselected' + widget.id.toString());
        Provider.of<SelectedItems>(context, listen: false).deselect(widget.id);
      } else {
        isSelected = true;
        Provider.of<SelectedItems>(context, listen: false).select(widget.id);
      }
      ;
      print(isSelected);
    }

    return GestureDetector(
      onLongPress: () => select(),
      onTap: () => {
        if (selected.length == 0)
          {
            Provider.of<SelectedItems>(context, listen: false).empty(),
            Navigator.of(context).pushNamed(BlogDetail.routeName,
                arguments: widget.id.toString())
          }
        else
          {select()}
      },
      child: Container(
        height: 300,
        width: null,
        child: Stack(children: [
          Card(
              color:
                  isSelected ? Colors.purple.withOpacity(0.08) : Colors.white,
              elevation: 5,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      flex: 1,
                      child: Container(
                        color: Colors.grey,
                        child: Center(
                          child: Text(
                            widget.date,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )),
                  Flexible(
                    flex: 6,
                    child: isnull
                        ? Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                            image: FileImage(File(widget.image)),
                            fit: BoxFit.cover,
                          )))
                        : Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage('assets/default.jpg'),
                              fit: BoxFit.cover,
                            )),
                          ),
                  ),
                  Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 0, left: 8.0),
                        child: Text(widget.title,
                            maxLines: 3,
                            style: TextStyle(
                                color: ArgonColors.header, fontSize: 18)),
                      )),
                  Flexible(
                    flex: 2,
                    child: ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton(
                          color: Colors.grey[200],
                          onPressed: () => {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    buildPopupDialog(
                                        context,
                                        widget.id.toString(),
                                        "The Post Will Be Permanently deleted")),
                          },
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        FlatButton(
                          color: Colors.grey[200],
                          onPressed: () => {
                            Navigator.of(context).pushNamed(
                                CreateBlog.routeName,
                                arguments: widget.id.toString())
                          },
                          child: Text(
                            'Edit',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        FlatButton(
                          onPressed: () => {
                            if (widget.image != null && widget.image != '')
                              {
                                Share.shareFiles([widget.image],
                                    text: widget.title)
                              }
                            else
                              {Share.share(widget.title)}
                          },
                          color: Colors.grey[200],
                          child: Text(
                            'share',
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
          Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.check_circle,
              size: 50,
              color: isSelected ? Colors.purple : Colors.transparent,
            ),
          ),
        ]),
      ),
    );
  }
}
