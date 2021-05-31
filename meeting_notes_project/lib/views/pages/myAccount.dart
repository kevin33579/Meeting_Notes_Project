part of 'pages.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key key}) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Account"),
        ),
        body: Stack(children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton.icon(
              onPressed: () async {
                setState(() {
                  isloading = true;
                });
                await AuthServices.SignOut().then((value) {
                  if (value == true) {
                    setState(() {
                      isloading = false;
                    });
                    ActivityServices.showToast("Logout success", Colors.green);
                    Navigator.pushReplacementNamed(context, Login.routeName);
                  } else {
                    setState(() {
                      isloading = false;
                    });
                    ActivityServices.showToast("Logout failed", Colors.red);
                  }
                });

                //Navigator.pushReplacementNamed(context, MainMenu.routeName);
              },
              icon: Icon(Icons.logout),
              label: Text("Logout"),
              style: ElevatedButton.styleFrom(
                primary: Colors.cyan,
                elevation: 0,
              ),
            ),
          ),
        ]));
  }
}
