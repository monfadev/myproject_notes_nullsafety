part of 'views.dart';

class AddNotes extends StatefulWidget {
  final MyNotes note;
  final String textHeader;

  AddNotes(this.note, this.textHeader);

  @override
  _AddNotesState createState() => _AddNotesState(this.note, this.textHeader);
}

class _AddNotesState extends State<AddNotes> {
  String textHeader; //for Header
  _AddNotesState(this.note, this.textHeader);

  bool changeicon = true; //for icon
  IconData icon;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  MyNotes note; //for initstate
  DatabaseHelper helper = DatabaseHelper();

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // void _showAlertDialog(String message) {
  //   AlertDialog alertDialog = AlertDialog(
  
  //     content: Text(message),
  //   );
  //   showDialog(context: context, builder: (_) => alertDialog);
  // }

  // Update the title of Note object
  void updateTitle() {
    note.title = titleController.text;
  }

  // Update the description of Note object
  void updateBody() {
    note.body = bodyController.text;
  }

  // Save data to database
  void _save() async {
    moveToLastScreen();

    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {
      // Case 1: Update operation
      result = await helper.updateNote(note);
    } else {
      // Case 2: Insert Operation
      result = await helper.insertNote(note);
    }

    if (result != 0) {
      // Success
      print( 'Note Saved Successfully');
    } else {
      // Failure
      print('Problem Saving Note');
    }
  }

  void _delete() async {
    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    // if (note.id == null) {
    //   _showAlertDialog('Status', 'No Note was deleted');
    //   return;
    // }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteNote(note.id);
    if (result != 0) {
      print('Note Deleted Successfully');
    } else {
      print('Error Occured while Deleting Note');
    }
  }

  void iconmenu() {
    setState(() {
      if (changeicon) {
        changeicon = false;
        icon = Icons.menu;
      } else {
        changeicon = true;
        icon = Icons.done;
      }
      print('change icon');
    });
  }

  void displaySnackbar(BuildContext context) {
    final snackBar = SnackBar(
      action: SnackBarAction(
        textColor: Color(0xFFE6EAF2),
        label: "Tap Here",
        onPressed: () {
          setState(() {
            debugPrint("Delete button clicked");
            _delete();
          });
        },
      ),
      content: Row(
        children: [
          Icon(Icons.delete, color: Color(0xFFE6EAF2)),
          Text('  Delete Notes?',
              style: GoogleFonts.lato(
                  color: Color(0xFFE6EAF2),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500)),
        ],
      ),
      backgroundColor: Color(0xFFEC564D),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = note.title;
    bodyController.text = note.body;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(135),
        child: Container(
          padding: EdgeInsets.all(26.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  print('ini back');
                  Navigator.pop(context);
                },
                child: Container(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF1D2A64),
                  ),
                ),
              ),
              //textHeader
              Center(
                child: Text(textHeader,
                    style: GoogleFonts.lato(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D2A64))),
              ),
              if (changeicon == true)
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: () {
                      setState(() {});
                      displaySnackbar(context);
                    },
                    child: Icon(
                      Icons.menu,
                      color: Color(0xFF1D2A64),
                    ),
                  ),
                )
              else
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _save();
                      print('save notes');
                    });
                  },
                  child: Icon(
                    Icons.done,
                    color: Color(0xFF1D2A64),
                  ),
                ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(26.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Color(0xFFFBFCFD),
              border: Border.all(color: Color(0xFFE6EAF2)),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0))),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              TextField(
                onTap: iconmenu,
                controller: titleController,
                onChanged: (value) {
                  debugPrint('Something changed in Title Text Field');
                  updateTitle();
                },
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: "Title",
                  hintStyle: GoogleFonts.lato(
                      color: Color(0xFFD2D9DF), fontSize: 16.0),
                ),
                style: GoogleFonts.lato(
                    color: Color(0xFF1D2A64),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500),
                maxLines: 2,
              ),
              TextField(
                onTap: iconmenu,
                controller: bodyController,
                onChanged: (value) {
                  debugPrint('Something changed in Body Text Field');
                  updateBody();
                },
                decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: "Body",
                    hintStyle: GoogleFonts.lato(
                        color: Color(0xFFD2D9DF), fontSize: 16.0)),
                style: GoogleFonts.lato(
                    color: Color(0xFF1D2A64),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500),
                maxLines: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
