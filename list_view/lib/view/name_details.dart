import 'package:flutter/material.dart';

class NameDetails extends StatefulWidget {
  const NameDetails({Key key}) : super(key: key);

  @override
  _NameDetailsState createState() => _NameDetailsState();
}

class _NameDetailsState extends State<NameDetails> {
  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context).settings.arguments as String;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200.0,
          floating: true,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                )),
          ),
        ),
      ],
    );
  }
}
