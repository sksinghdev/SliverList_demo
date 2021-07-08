import 'dart:async';

class CustomListData {
  final _stateStreamController = StreamController<List<String>>.broadcast();

  StreamSink<List<String>> get customListSink => _stateStreamController.sink;

  Stream<List<String>> get customListStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<String>.broadcast();

  StreamSink<String> get eventSink => _eventStreamController.sink;

  Stream<String> get eventStream => _eventStreamController.stream;

  CustomListData() {
    eventStream.listen((event) async {
      try {
        customListSink.add(await getStringList(event.toString()));
      } on Exception catch (e) {
        customListSink.addError("Something went wrong");
      }
    });
  }

  Future<List<String>> getStringList(String value) async {
    var duplicateItems = getcontacts();
    List<String> data = [];
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if (value.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.toLowerCase().contains(value.toLowerCase())) {
          dummyListData.add(item);
        } else {}
      });
      data.clear();
      data.addAll(dummyListData);
    } else {
      data.clear();
      data.addAll(duplicateItems);
    }
    return data;
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }

  getcontacts() {
    return ['Marco Franco', 'Raul Alday', 'Jessica Alba', 'Roger Waters', 'Darth Vader', 'Homer Simpson', 'Bill Gates',
      'Elon Musk', 'Enrique Peña', 'Angeles Rodriguez', 'Monica Alvarado', 'Estrella Fugaz', 'Juana Lopez',];
  }
}
