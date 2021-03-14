part of 'components.dart';

class ProfileAnimationImplementation extends StatefulWidget {
  final Function onTab;

  const ProfileAnimationImplementation({Key key, this.onTab}) : super(key: key);
  @override
  _ProfileAnimationImplementationState createState() =>
      _ProfileAnimationImplementationState();
}

class _ProfileAnimationImplementationState
    extends State<ProfileAnimationImplementation> {
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
                    margin: EdgeInsets.all(26),
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                        color: Color(0xFFFBFCFD),
                        image: DecorationImage(
                          image: AssetImage("assets/images/image_profile.png"),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFF01579B).withOpacity(0.1),
                              blurRadius: 1.0,
                              offset: Offset(0, 2))
                        ],
                        borderRadius: BorderRadius.circular(15.0)),
                    //TODOS Dapat di buat child.
                  ),
                )
              : Container(
                  margin: EdgeInsets.all(26),
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                      color: Color(0xFFFBFCFD),
                      image: DecorationImage(
                        image: AssetImage("assets/images/image_profile.png"),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF01579B).withOpacity(0.1),
                            blurRadius: 1.0,
                            offset: Offset(0, 2))
                      ],
                      borderRadius: BorderRadius.circular(15.0)),
                ),
        ),
      ),
    );
  }
}
