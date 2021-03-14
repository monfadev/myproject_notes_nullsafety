part of 'components.dart';

class FabAnimationImplementation extends StatefulWidget {
  final Function onTab;

  const FabAnimationImplementation({Key key, this.onTab}) : super(key: key);
  @override
  _FabAnimationImplementationState createState() =>
      _FabAnimationImplementationState();
}

class _FabAnimationImplementationState
    extends State<FabAnimationImplementation> {
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
                  child: FloatingActionButton(
                    child: Icon(Icons.add, color: Color(0xFFD2D9DF)),
                    backgroundColor: Color(0xFF1D2A64),
                    onPressed: null,
                    //TODOS null karna sudah ada di line 35.
                  ),
                )
              : FloatingActionButton(
                  child: Icon(Icons.add, color: Color(0xFFD2D9DF)),
                  backgroundColor: Color(0xFF1D2A64),
                  onPressed: null,
                  //TODOS null karna sudah ada di line 35.
                ),
        ),
      ),
    );
  }
}
