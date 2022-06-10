import 'package:flutter/widgets.dart';

class Provider<B> extends InheritedWidget {
  final B bloc;

  const Provider({
    Key key,
    this.bloc,
    Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(Provider<B> oldWidget) => child == oldWidget.child;

  static B of<B>(BuildContext context) => context.dependOnInheritedWidgetOfExactType<Provider<B>>().bloc;
}

class BlocProvider<B> extends StatefulWidget {
  final void Function(B bloc) onDispose;
  final B Function(B bloc) initBloc;
  final Widget child;

  const BlocProvider({
    Key key,
    @required this.child,
    @required this.initBloc,
    @required this.onDispose,
  }) : super(key: key);

  @override
  _BlocProviderState<B> createState() => _BlocProviderState<B>();
}

class _BlocProviderState<B> extends State<BlocProvider<B>> {
  B bloc;

  @override
  void initState() {
    super.initState();
    if (widget.initBloc != null) bloc = widget.initBloc(bloc);
  }

  @override
  void dispose() {
    if (widget.onDispose != null) widget.onDispose(bloc);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Provider(
        bloc: bloc,
        child: widget.child,
      );
}
