import 'package:flutter/material.dart';
import 'package:myevent/src/utils/colors.dart';

class IconBadge extends StatefulWidget {
  final IconData icon;
  final bool active;

  IconBadge({Key key, @required this.icon, this.active}) : super(key: key);

  @override
  _IconBadgeState createState() => _IconBadgeState();
}

class _IconBadgeState extends State<IconBadge> {
  @override
  Widget build(BuildContext context) {
    if (widget.active) {
      return Stack(
        children: <Widget>[
          Icon(
            widget.icon,
            color: primaryColor,
          ),
          Positioned(
            right: 0,
            child: Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),
              ),
              constraints: BoxConstraints(
                minWidth: 11,
                minHeight: 11,
              ),
              /* child: Text(
                widget.notifs.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),*/
            ),
          )
        ],
      );
    } else {
      return Stack(
        children: <Widget>[
          Icon(
            widget.icon,
            color: primaryColor,
          ),
        ],
      );
    }
  }
}
