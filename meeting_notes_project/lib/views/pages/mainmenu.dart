part of 'pages.dart';

class MainMenu extends StatefulWidget {
  static const String routeName = "/mainmenu";

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String text = 'Press the button and start speaking';
  bool isListening = false;
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    AddData(),
    ListData(),
    MyAccount(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.content_copy),
              onPressed: () async {
                await FlutterClipboard.copy(text);

                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('✓   Copied to Clipboard')),
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _widgetOptions.elementAt(_selectedIndex),
          SingleChildScrollView(
            reverse: true,
            padding: const EdgeInsets.all(30).copyWith(bottom: 150),
            child: SubstringHighlight(
              text: text,
              terms: Command.all,
              textStyle: TextStyle(
                fontSize: 32.0,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              textStyleHighlight: TextStyle(
                fontSize: 32.0,
                color: Colors.red,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.note_add_rounded),
            label: "Add Data",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "List Data",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "My Account",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: isListening,
        endRadius: 75,
        glowColor: Theme.of(context).primaryColor,
        child: FloatingActionButton(
          child: Icon(isListening ? Icons.mic : Icons.mic_none, size: 36),
          onPressed: toggleRecording,
        ),
      ),
    );
  }
  Future toggleRecording() => SpeechApi.toggleRecording(
    onResult: (text) => setState(() => this.text = text),
    onListening: (isListening) {
      setState(() => this.isListening = isListening);

      if (!isListening) {
        Future.delayed(Duration(seconds: 1), () {
          Utils.scanText(text);
        });
      }
    },
  );
}
