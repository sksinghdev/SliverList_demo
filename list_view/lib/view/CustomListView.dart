import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_view/controller/CustomListData.dart';
import 'package:list_view/view/name_details.dart';

class CustomListView extends StatefulWidget {
  @override
  _CustomListViewState createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  final TextEditingController _searchQuery = new TextEditingController();
  bool isSearchClicked = false;
  final dataBlock = CustomListData();
  Icon _searchIcon = Icon(
    Icons.search,
  );

  @override
  void initState() {
    dataBlock.eventSink.add('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder<List<String>>(
        stream: dataBlock.customListStream,
        builder: (context, snapshots) {
          if (snapshots.hasData) return getMainView(snapshots.data);
          if (snapshots.connectionState == ConnectionState.waiting)
            return Container(
              child: Center(
                child: getTextView("Waiting..."),
              ),
            );
          if (snapshots.hasError)
            return Container(
              child: Center(
                child: getTextView(snapshots.error),
              ),
            );
        },
      )),
    );
  }

  Widget getTextView(String textMessage) {
    return new Text(textMessage,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15));
  }

  Widget buildName(BuildContext context, String name) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: Colors.grey.withOpacity(0.6),
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
        child: InkWell(
          onTap: () {},
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _CustomListViewState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        //TODO call for all Data
        dataBlock.eventSink.add('');
      } else {
        //TODO call for value data
        dataBlock.eventSink.add(_searchQuery.text);
      }
    });
  }

  @override
  void dispose() {
    dataBlock.dispose();
    _searchQuery.dispose();
    super.dispose();
  }

  Widget getMainView(List<String> contacts) {
    return CustomScrollView(slivers: [
      createSilverAppBar(),
      SliverToBoxAdapter(
        child: Container(
          color: Colors.grey.withOpacity(0.4),
          padding: const EdgeInsets.all(8.0),
          child: Text('Name Header',
              style: TextStyle(fontSize: 24, color: Colors.white)),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NameDetails(),
                    settings: RouteSettings(
                      arguments: contacts[index],
                    ),
                  ),
                );
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                color: Colors.orange[100 * (index % 9)],
                child: Text(
                  contacts[index],
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            );
          },
          childCount: contacts.length,
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          color: Colors.grey.withOpacity(0.4),
          padding: const EdgeInsets.all(8.0),
          child: Text('Name Footer',
              style: TextStyle(fontSize: 24, color: Colors.white)),
        ),
      ),
    ]);
  }

  Widget createSilverAppBar() {
    return SliverAppBar(
      actions: <Widget>[
        RawMaterialButton(
          elevation: 0.0,
          child: _searchIcon,
          onPressed: () {
            _searchPressed();
          },
          constraints: BoxConstraints.tightFor(
            width: 56,
            height: 56,
          ),
          shape: CircleBorder(),
        ),
      ],
      expandedHeight: 100,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(bottom: 15),
        centerTitle: true,
        title: isSearchClicked
            ? Container(
                padding: EdgeInsets.only(bottom: 2),
                constraints: BoxConstraints(minHeight: 30, maxHeight: 30),
                width: 220,
                child: CupertinoTextField(
                  controller: _searchQuery,
                  keyboardType: TextInputType.text,
                  placeholder: "Search name",
                  placeholderStyle: TextStyle(
                    color: Color(0xffC4C6CC),
                    fontSize: 14.0,
                    fontFamily: 'Brutal',
                  ),
                  prefix: Padding(
                    padding: const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
                    child: Icon(
                      Icons.search,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                ),
              )
            : Text("Search user name"),
      ),
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(
          Icons.close,
        );
        isSearchClicked = true;
      } else {
        this._searchIcon = Icon(
          Icons.search,
        );
        isSearchClicked = false;
        _searchQuery.clear();
      }
    });
  }
}
