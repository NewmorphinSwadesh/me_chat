import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'customDialog.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("P2P chat"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ),
        body: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text('U 1'),
                ),
                IconButton(
                    icon: Icon(Icons.keyboard_arrow_right), onPressed: () {}),
                Text("Hey man !"),
              ],
            ),
            Row(
              children: [
                CircleAvatar(
                  child: Text('U 1'),
                ),
                IconButton(
                    icon: Icon(Icons.keyboard_arrow_right), onPressed: () {}),
                Text("WhatsUp"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Yo Mate !"),
                IconButton(
                    icon: Icon(Icons.keyboard_arrow_left), onPressed: () {}),
                CircleAvatar(
                  child: Text('U 2'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("What about you ?"),
                IconButton(
                    icon: Icon(Icons.keyboard_arrow_left), onPressed: () {}),
                CircleAvatar(
                  child: Text('U 2'),
                ),
              ],
            ),
            Expanded(child: Container()),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width * .8,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.keyboard),
                      hintText: 'Reply Here',
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.attach_file_sharp,
                      size: 25,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => CustomDialog(
                          title: "Success",
                          description:
                              "Flutter Tutorial is best provide tutorial.",
                          buttonText: "Okay",
                        ),
                      );
                    })
              ],
            )
          ],
        ));
  }
}
