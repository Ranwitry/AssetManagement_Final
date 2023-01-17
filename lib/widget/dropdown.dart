import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  const MyDropdown({
    this.selectValue,
    this.hint,
    this.onChanged,
    this.listDropdown,
  });

  final String? selectValue;
  final String? hint;
  final ValueChanged? onChanged;
  final List? listDropdown;

  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: DropdownButton<String>(
          isExpanded: true,
          value: widget.selectValue,
          hint: Text(widget.hint!),
          underline: Container(color: Colors.white),
          onChanged: widget.onChanged,
          items: widget.listDropdown!.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
