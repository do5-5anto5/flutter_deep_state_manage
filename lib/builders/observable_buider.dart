import 'package:flutter/material.dart';
import 'package:flutter_deep_state_manage/contracts/observable.dart';

class ObservableBuider extends StatefulWidget {
  final Observable observable;
  final Widget Function(BuildContext context, Widget? child) builder;
  final Widget? child;
  const ObservableBuider({
    super.key,
    required this.observable,
    required this.builder,
    /** O widget child somente vai ser renderizado, e nao reconstruido, se o observable for alterado.
     * Isso significa que o widget child não será reconstruído a menos que o observable notifique.
     * O child é optional, permitindo que você passe um widget filho para ser usado no builder, ou não.
     * Se não for passado, o builder não terá um widget filho.**/
    this.child,
  });

  @override
  State<ObservableBuider> createState() => _ObservableBuiderState();
}

class _ObservableBuiderState extends State<ObservableBuider> {
  @override
  void initState() {
    widget.observable.addListener(rebuild);
    super.initState();
  }

  void rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.child);
  }

  @override
  void dispose() {
    widget.observable.removeListener(rebuild);
    super.dispose();
  }
}
