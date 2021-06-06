part of 'pages.dart';

class Record extends StatefulWidget {
  const Record({Key key}) : super(key: key);

  @override
  _RecordState createState() => _RecordState();
}

class _RecordState extends State<Record> {
  String text = 'Press the button and start speaking';
  final _formKey = GlobalKey<FormState>();
  final ctrlNotesName = TextEditingController();
  bool isListening = false;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Record"),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.save_alt),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    isloading = true;
                  });
                  Notes notes = Notes("",ctrlNotesName.text,text,"","");
                  await NotesServices.addNotes(notes).then((value){
                    if (value == true){
                      ActivityServices.showToast("save notes success", Colors.green);
                      setState(() {
                        isloading = false;
                      });
                    }else{
                      ActivityServices.showToast("save notes failed", Colors.red);
                    }
                  });
                }else{
                  ActivityServices.showToast("please check the fields!", Colors.red);
                }

              }
            ),
          ),
          isloading == true ? ActivityServices.loadings() : Container()
        ],
      ),
      body: Stack(
      children : [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: ctrlNotesName,
                decoration: InputDecoration(
                  labelText: "Name",
                  prefixIcon: Icon(Icons.drive_file_rename_outline),
                  border: OutlineInputBorder(),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter name for saving";
                  } else {
                    return null;
                  }
                },
              ),
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
        ),

      ]
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
