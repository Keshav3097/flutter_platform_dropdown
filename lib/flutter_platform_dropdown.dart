library flutter_platform_dropdown;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'dropdown_button2.dart';

class PlatformDropdown extends StatefulWidget {
  final double width;
  final String hintText;
  final String heading;
  final bool required;
  final bool showRequiredIcon;
  String selectedValue;
  final List<DropDownModel> items;
  final Function(String val) onChange;

  PlatformDropdown({
    required this.width,
    required this.selectedValue,
    required this.items,
    required this.onChange,
    this.hintText="",
    this.heading="",
    this.required=false,
    this.showRequiredIcon = true,
  });

  @override
  State<PlatformDropdown> createState() => _PlatformDropdownState();
}

class _PlatformDropdownState extends State<PlatformDropdown> {
  int selectedIndex = 0;
  String iosDisplayValue = "Select Item";

  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS)
    {
      selectedIndex = widget.items.indexWhere((element) => element.value == widget.selectedValue);
      iosDisplayValue = widget.items.where((element) => element.value == widget.selectedValue).first.text;
    }

    if(widget.selectedValue.isEmpty)
    {
      widget.selectedValue = widget.items[0].value;
    }

    return SizedBox(
      width: widget.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Column(
            children: [
              Platform.isIOS ?
              GestureDetector(
                onTap: () {

                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext builder) {
                        return Container(
                          height: 200,
                          color: Colors.white,
                          child: CupertinoTheme(
                            data: const CupertinoThemeData(
                              textTheme: CupertinoTextThemeData(
                                //dateTimePickerTextStyle: CupertinoTheme.of(context).textTheme.dateTimePickerTextStyle,
                                  textStyle: TextStyle(color: Colors.black,fontSize: 16)
                              ),
                              scaffoldBackgroundColor: Colors.grey,
                              barBackgroundColor: Colors.blue,
                            ),
                            child: CupertinoPicker(
                              onSelectedItemChanged: (value){
                                //setState(() {
                                selectedIndex = value;
                                widget.selectedValue = widget.items[selectedIndex].value.toString();
                                widget.onChange(widget.items[selectedIndex].value.toString());
                                iosDisplayValue = widget.items[selectedIndex].text;
                                //});
                              },
                              scrollController: FixedExtentScrollController(initialItem: selectedIndex),
                              itemExtent: 32.0,
                              diameterRatio: 1,
                              useMagnifier: true,
                              backgroundColor: Colors.grey.shade100,
                              magnification: 1,
                              selectionOverlay: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    color: Colors.grey.withOpacity(0.2)
                                ),
                              ),
                              children: widget.items.map((e)
                              {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  alignment: Alignment.center,
                                  child: Text(
                                    e.text,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(color: Colors.black,fontSize: 16),
                                  ),
                                );
                                //return Text(e.text,style: CupertinoTheme.of(context).textTheme.dateTimePickerTextStyle,maxLines: 1,);
                              }).toList(),
                            ),
                          ),
                        );
                      }
                  );

                },
                child: Container(
                  width: widget.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey
                      ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child:Text(
                          iosDisplayValue,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.arrow_drop_down,
                          size: 25,
                        ),
                      )
                    ],
                  ),
                ),
              ) :
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    size: 25,
                  ),
                  iconSize: 15,
                  iconEnabledColor: Colors.grey,
                  buttonWidth: widget.width,
                  buttonDecoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    color: Colors.white,
                  ),
                  buttonPadding: const EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.center,
                  dropdownMaxHeight: 300,
                  dropdownWidth: widget.width,
                  dropdownDecoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  selectedItemHighlightColor: Colors.grey.shade400,
                  dropdownElevation: 8,
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                  items: widget.items.map((e)
                  {
                    return DropdownMenuItem(value: e.value,child:Text(e.text,style: const TextStyle(color: Colors.black,fontSize: 16),textAlign: TextAlign.start,overflow: TextOverflow.ellipsis,maxLines: 1));
                  }).toList(),
                  value: widget.selectedValue,
                  onChanged: (value) {
                    setState(() {
                      widget.selectedValue = value as String;
                      widget.onChange(value);
                    });
                  },
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}

class DropDownModel {
  String text;
  String value;
  DropDownModel({required this.text,required this.value});
}