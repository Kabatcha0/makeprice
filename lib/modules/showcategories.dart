import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makeprice/components/components.dart';
import 'package:makeprice/layout/cubit/cubit.dart';
import 'package:makeprice/layout/cubit/states.dart';
import 'package:makeprice/layout/layout.dart';
import 'package:makeprice/modules/newitem.dart';

class Show extends StatelessWidget {
  GlobalKey<ScaffoldState> skey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> makePriceCity;
  int index;
  Show({required this.makePriceCity, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PriceCubit, PriceStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = PriceCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      )),
                ),
              ],
              leading: IconButton(
                  onPressed: () {
                    pushReplacement(context: context, widget: Layout());
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              title: const Text(
                "Categories",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              backgroundColor: const Color.fromARGB(255, 41, 37, 37),
            ),
            backgroundColor: Colors.black,
            key: skey,
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ConditionalBuilder(
                    condition: true,
                    fallback: (context) => const Icon(
                      Icons.list,
                      size: 50,
                      color: Colors.white,
                    ),
                    builder: (context) => ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: makePriceCity.isNotEmpty,
                        itemBuilder: (context, index) => listTile(
                            item: makePriceCity[index]["item"],
                            sale: makePriceCity[index]["sale"],
                            size: makePriceCity[index]["size"],
                            function: () {
                              skey.currentState!.showBottomSheet((context) =>
                                  container(
                                      file: base64Decode(
                                          makePriceCity[index]["pic"]),
                                      item: makePriceCity[index]["item"],
                                      category: makePriceCity[index]
                                          ["categories"],
                                      size: makePriceCity[index]["size"],
                                      quantity: makePriceCity[index]
                                          ["quantity"],
                                      cost: makePriceCity[index]["cost"],
                                      sale: makePriceCity[index]["sale"],
                                      description: makePriceCity[index]
                                          ["description"]));
                            }),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 5,
                            ),
                        itemCount: makePriceCity.length),
                  )
                ],
              ),
            ),
          );
        });
  }
}
