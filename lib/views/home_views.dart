part of 'views.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  //Deklarasi
  TextEditingController searchtext = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<MyNotes> noteList;
  int count = 0;

  //Method cek query
  void queryall() async {
    var allrows = await databaseHelper.queryall();
    allrows.forEach((row) {
      print(row);
    });
  }

  //Method cek database
  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<MyNotes>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  void navigateToDetail(MyNotes note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddNotes(note, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Height is ${MediaQuery.of(context).size.height}');
    print('Width is ${MediaQuery.of(context).size.width}');
    if (noteList == null) {
      noteList = List<MyNotes>();
      updateListView();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      //TODOS FAB
      floatingActionButton: Container(
        child: FabAnimationImplementation(
          onTab: () {
            ButtonAnimation.disableButton
                ? print("Disable true")
                : print("Button FAB for add notes");
            navigateToDetail(
                MyNotes(titleModels: '', bodyModels: '', createDateModels: ''),
                'Add Note');
          },
        ),
      ),

      //TODOS Body
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            //TODOS Header
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(26),
                    child: Text("My Notes",
                        style: GoogleFonts.lato(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D2A64))),
                  ),
                  Container(
                    child: ProfileAnimationImplementation(
                      onTab: () {
                        ButtonAnimation.disableButton
                            ? print("Disable true")
                            : print("Button Profile");
                        queryall();
                      },
                    ),
                  ),
                ],
              ),
            ),
            //TODOS Search
            SliverToBoxAdapter(
              child: Container(
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
                      controller: searchtext,
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
                      child: Icon(
                        Icons.search,
                        color: Color(0xFFD2D9DF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //TODOS Total Notes
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(top: 15.0, right: 26.0),
                          height: MediaQuery.of(context).size.height / 11,
                          width: MediaQuery.of(context).size.height / 4,
                          decoration: BoxDecoration(
                              color: Color(0xFF1D2A64),
                              borderRadius: BorderRadius.circular(18.0)),
                          child: FutureBuilder(
                            future: databaseHelper.getCount(),
                            builder: (context, snapshot) {
                              print(snapshot.data);
                              if (snapshot.data == null) {
                                return Center(
                                    child: Text("0" + " Notes",
                                        style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500,
                                        )));
                              } else {
                                return Center(
                                    child: Text(
                                        snapshot.data.toString() + " Notes",
                                        style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500,
                                        )));
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(26.0),
                child: Text("Most Recent Notes",
                    style: GoogleFonts.lato(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D2A64))),
              ),
            ),
            //Futurebuilder berfungsi untuk menampung propery future pada suatu
            //fungsi dengan widget future
            // SliverFillRemaining(
            //   child: FutureBuilder(
            //     // future: database.getNotes(),
            //     builder: (context, snapshot) {
            //       print(snapshot.data);
            //       if (snapshot.data == null) {
            //         return Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       } else {
            //         return ListMyNotes(notedata: snapshot.data);
            //       }
            //     },
            //   ),
            // ),
            SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.0),
                  child: ButtonAnimationImplementation(
                    title: noteList[index].title,
                    body: noteList[index].body,
                    tanggal: noteList[index].date,
                    onTab: () {
                      ButtonAnimation.disableButton
                          ? print("Disable true")
                          : print("I'm pressed for edit");
                      navigateToDetail(noteList[index], "Edit Note");
                    },
                  ),
                );
              }, childCount: count),
            ),
          ],
        ),
      ),
    );
  }
}
