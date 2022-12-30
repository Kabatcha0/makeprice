import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:makeprice/components/components.dart';
import 'package:makeprice/layout/cubit/cubit.dart';
import 'package:makeprice/layout/cubit/states.dart';
import 'package:makeprice/layout/layout.dart';

class NewItem extends StatelessWidget {
  String? noOfEmployees;
  String? city;
  NewItem({this.noOfEmployees, this.city});
  GlobalKey<ScaffoldState> skey = GlobalKey<ScaffoldState>();
  TextEditingController category = TextEditingController();
  TextEditingController item = TextEditingController();
  TextEditingController size = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController sale = TextEditingController();
  TextEditingController cost = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PriceCubit, PriceStates>(
      listener: (context, state) {},
      builder: (context, state) => Builder(builder: (context) {
        code.text = PriceCubit.get(context).scannerNewItem;
        var cubit = PriceCubit.get(context);
        return Scaffold(
          key: skey,
          backgroundColor: Colors.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromARGB(255, 41, 37, 37),
            title: Container(
              alignment: Alignment.centerRight,
              child: const Text(
                "Add New Item",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    skey.currentState!.showBottomSheet((context) => Container(
                          width: double.infinity,
                          height: 170,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                takeImage(
                                    text: "Take Photo",
                                    function: () {
                                      PriceCubit.get(context)
                                          .imageCamera()
                                          .then((value) {
                                        Navigator.pop(context);
                                      });
                                    },
                                    icon: Icons.camera),
                                const SizedBox(
                                  height: 22,
                                ),
                                takeImage(
                                    text: "Choose from Gallery",
                                    function: () {
                                      PriceCubit.get(context)
                                          .imageGallery()
                                          .then((value) {
                                        Navigator.pop(context);
                                      });
                                    },
                                    icon: Icons.photo),
                                const SizedBox(
                                  height: 22,
                                ),
                                takeImage(
                                    text: "Cancel",
                                    function: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icons.cancel),
                              ],
                            ),
                          ),
                        ));
                    print("hi");
                  },
                  child: Container(
                      width: double.infinity,
                      height: 180,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.red, Colors.black])),
                      alignment: Alignment.center,
                      child: PriceCubit.get(context).croppedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                  height: 150,
                                  width: 150,
                                  child: Image.file(
                                      PriceCubit.get(context).croppedImage!,
                                      fit: BoxFit.cover)),
                            )
                          : const Icon(
                              Icons.camera,
                              color: Colors.white,
                              size: 50,
                            )),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text(text: "Category"),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            color: const Color.fromARGB(255, 41, 37, 37),
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton(
                                    isExpanded: true,
                                    dropdownColor: Colors.red,
                                    iconDisabledColor: Colors.white,
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: cubit.items[0],
                                        child: Text(
                                          cubit.items[0],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: cubit.items[1],
                                        child: Text(
                                          cubit.items[1],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: cubit.items[2],
                                        child: Text(
                                          cubit.items[2],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: cubit.items[3],
                                        child: Text(
                                          cubit.items[3],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                    value: cubit.item,
                                    onChanged: (v) {
                                      cubit.selectedItem(v!);
                                    }),
                              ),
                            )
                            // DropDown(
                            //   items: items,
                            //   dropDownType: DropDownType.Button,
                            //   isCleared: true,
                            //   isExpanded: true,
                            //   showUnderline: false,
                            //   hint: const Text(
                            //     "Uncategorized",
                            //     style: TextStyle(color: Colors.white),
                            //   ),
                            //   icon: const Icon(
                            //     Icons.expand_more,
                            //     color: Colors.white,
                            //   ),
                            //   onChanged: (v) {

                            //   },
                            // ),
                            ),
                        const SizedBox(
                          height: 10,
                        ),
                        text(text: "Item Name"),
                        const SizedBox(
                          height: 4,
                        ),
                        textFromField(controller: item),
                        const SizedBox(
                          height: 10,
                        ),
                        text(text: "Size/Weight"),
                        const SizedBox(
                          height: 4,
                        ),
                        textFromField(hint: true, controller: size),
                        const SizedBox(
                          height: 10,
                        ),
                        text(text: "Quantity"),
                        const SizedBox(
                          height: 4,
                        ),
                        textFromField(hint: true, controller: quantity),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text(text: "Sale price (\$)"),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  textFromField(controller: sale, hint: true),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text(text: "Cost price (\$)"),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  textFromField(controller: cost),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        text(text: "Description"),
                        const SizedBox(
                          height: 4,
                        ),
                        textFromField(controller: description),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                text(text: ""),
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                    color:
                                        const Color.fromARGB(255, 41, 37, 37),
                                    child: IconButton(
                                        onPressed: () {
                                          PriceCubit.get(context)
                                              .readScannerNewItem();
                                        },
                                        icon: const Icon(
                                          Icons.qr_code,
                                          color: Colors.white,
                                        ))),
                              ],
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  text(text: "UPC Code"),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  textFromField(controller: code, hint: true),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        button(function: () {
                          PriceCubit.get(context).insert(
                              city: city == null ? "None" : city!,
                              no: noOfEmployees == null
                                  ? "None"
                                  : noOfEmployees!,
                              pic: PriceCubit.get(context).base64Image!,
                              categories: cubit.item!,
                              item: item.text,
                              size: size.text == "" ? "None" : size.text,
                              quantity:
                                  quantity.text == "" ? "None" : quantity.text,
                              code: code.text == "" ? "None" : code.text,
                              description: description.text,
                              sale: sale.text == "" ? "None" : sale.text,
                              cost: cost.text);

                          push(context: context, widget: Layout(city: city));
                        }),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
