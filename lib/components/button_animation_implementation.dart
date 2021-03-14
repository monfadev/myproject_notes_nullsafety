part of 'components.dart';

class ButtonAnimationImplementation extends StatefulWidget {
  final String title;
  final String body;
  final String tanggal;
  final Function onTab;

  ButtonAnimationImplementation(
      {Key key, this.title, this.body, this.tanggal, this.onTab})
      : super(key: key);
  @override
  _ButtonAnimationImplementationState createState() =>
      _ButtonAnimationImplementationState();
}

class _ButtonAnimationImplementationState
    extends State<ButtonAnimationImplementation> {
  List<ListModels> listAllModelsButton = [];
  bool isPressed = false;
  double _scale = 0.986;

  void onPressedUp(PointerUpEvent event) {
    setState(() {
      isPressed = false;
    });
  }

  void onPressedDown(PointerDownEvent event) {
    setState(() {
      isPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ButtonAnimation(
      child: GestureDetector(
        onTap: widget.onTab,
        child: Listener(
          onPointerUp: onPressedUp,
          onPointerDown: onPressedDown,
          child: isPressed
              ? Transform.scale(
                  scale: _scale,
                  child: Container(
                    padding: EdgeInsets.all(13.0), // Text
                    height: MediaQuery.of(context).size.height / 7.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFFFBFCFD),
                        border: Border.all(color: Color(0xFFE6EAF2)),
                        borderRadius: BorderRadius.circular(18.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //TODOS Adanya flexible text menjadi.......
                        Flexible(
                          child: Text(widget.title,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF1D2A64))),
                        ),
                        SizedBox(height: 8.0),
                        Flexible(
                          child: Text(widget.body,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF1D2A64))),
                        ),
                        SizedBox(height: 7.0),
                        Flexible(
                          child: Text(widget.tanggal,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xFF1D2A64))),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(13.0), // Text
                  height: MediaQuery.of(context).size.height / 7.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFFFBFCFD),
                      border: Border.all(color: Color(0xFFE6EAF2)),
                      borderRadius: BorderRadius.circular(18.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //TODOS Adanya flexible text menjadi.......
                      Flexible(
                        child: Text(widget.title,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1D2A64))),
                      ),
                      SizedBox(height: 8.0),
                      Flexible(
                        child: Text(widget.body,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1D2A64))),
                      ),
                      SizedBox(height: 7.0),
                      Flexible(
                        child: Text(widget.tanggal,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w300,
                                color: Color(0xFF1D2A64))),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
