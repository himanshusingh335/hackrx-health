import 'package:finserv_health/provider/colors.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CustomDropdownMenu extends StatefulWidget {
  CustomDropdownMenu(
      {Key? key,
      @required String? dropDownValue,
      @required List<String>? list,
      @required String? labelText,
      IconData? icon})
      : _dropDownValue = dropDownValue!,
        _list = list!,
        _labelText = labelText!,
        _icon = icon!;

  String _dropDownValue;
  final List<String> _list;
  final String _labelText;
  final IconData _icon;

  @override
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: widget._dropDownValue,
      icon: Icon(
        Icons.arrow_downward,
        color: Provider.of<AppColors>(context, listen: false).myRed,
      ),
      elevation: 5,
      style: TextStyle(
        color: Provider.of<AppColors>(context, listen: false).myRed,
      ),
      decoration: InputDecoration(
        labelText: widget._labelText,
        labelStyle: TextStyle(
            color: Provider.of<AppColors>(context, listen: false).myBlue,
            fontWeight: FontWeight.bold),
        prefixIcon: Icon(widget._icon,
            color: Provider.of<AppColors>(context, listen: false).myRed),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      items: widget._list.map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          widget._dropDownValue = newValue!;
        });
      },
    );
  }
}
