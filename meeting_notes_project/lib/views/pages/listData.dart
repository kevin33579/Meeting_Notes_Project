part of 'pages.dart';

class ListData extends StatefulWidget {
  const ListData({Key key}) : super(key: key);

  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List data"),

      ),
    );
  }
}
