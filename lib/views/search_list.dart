part of 'views.dart';

class SearchList extends StatefulWidget {
  final List<MyNotes>? noteList;

  SearchList(this.noteList, {Key? key}) : super(key: key);

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<MyNotes>? noteList;
  int count = 0;

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
    bool? result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddNotes(note, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.noteList!.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.0),
            child: ButtonAnimationImplementation(
              title: widget.noteList![index].title,
              body: widget.noteList![index].body,
              tanggal: widget.noteList![index].date,
              onTab: () {
                ButtonAnimation.disableButton
                    ? print("Disable true")
                    : print("I'm pressed for edit");
                navigateToDetail(widget.noteList![index], "Edit Note");
              },
            ),
          );
        },
      ),
    );
  }
}
