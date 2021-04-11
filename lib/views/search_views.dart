part of 'views.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  String keyword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  margin: EdgeInsets.all(26.0),
                  height: MediaQuery.of(context).size.height / 20,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFFE6EAF2),
                      borderRadius: BorderRadius.circular(18.0)),
                  child: Stack(
                    children: [
                      TextField(
                        onChanged: (value) {
                          keyword = value;
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: "Search by title",
                            hintStyle: GoogleFonts.lato(
                                color: Color(0xFFD2D9DF), fontSize: 16.0)),
                        style: GoogleFonts.lato(
                            color: Color(0xFF1D2A64), fontSize: 16.0),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            print('back');
                          },
                          child: Icon(
                            Icons.clear_rounded,
                            color: Color(0xFFD2D9DF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: databaseHelper.searchTitle(keyword),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print('error');
                    return snapshot.hasData
                        ? SearchList(snapshot.data)
                        : new Center(
                            child: Text("Don't Have Notes..."),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
