part of 'pages.dart';

class AddData extends StatefulWidget {
  const AddData({Key key}) : super(key: key);

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add data"),

      ),
    );
  }
}
