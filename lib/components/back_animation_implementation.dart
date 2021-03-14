part of 'components.dart';

class BackAnimationImplementation extends StatefulWidget {
  final Function onTab;

  const BackAnimationImplementation({Key key, this.onTab}) : super(key: key);
  @override
  _BackAnimationImplementationState createState() =>
      _BackAnimationImplementationState();
}

class _BackAnimationImplementationState
    extends State<BackAnimationImplementation> {
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
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF1D2A64),
                  ),
                  //TODOS null karna sudah ada di line 35.
                )
              : Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF1D2A64),
                ),
          //TODOS null karna sudah ada di line 35.
        ),
      ),
    );
  }
}
