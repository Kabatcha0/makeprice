import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makeprice/components/components.dart';
import 'package:makeprice/layout/cubit/cubit.dart';
import 'package:makeprice/layout/cubit/states.dart';
import 'package:makeprice/modules/addbranches.dart';
import 'package:makeprice/modules/newitem.dart';
import 'package:makeprice/modules/showcategories.dart';

class Layout extends StatelessWidget {
  TextEditingController qrCode = TextEditingController();
  GlobalKey<ScaffoldState> skey = GlobalKey<ScaffoldState>();
  String? city;
  Layout({this.city});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PriceCubit, PriceStates>(
      builder: (context, state) {
        var cubit = PriceCubit.get(context);

        return Scaffold(
          key: skey,
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 41, 37, 37),
            leading: cubit.makePrice.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      skey.currentState!.showBottomSheet(
                        (context) => containerExport(functionPdf: () {
                          cubit.createPdf(
                              item: cubit.makePrice[0]["item"],
                              catogery: cubit.makePrice[0]["categories"]);
                        }, functionExcel: () {
                          cubit.createExcel(
                              item: cubit.makePrice[0]["item"],
                              price: cubit.makePrice[0]["sale"]);
                        }),
                      );
                    },
                    icon: const Icon(Icons.upload_file))
                : null,
            title: Container(
              alignment: Alignment.centerRight,
              child: const Text(
                "Branches",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 2,
                ),
                Container(
                  color: const Color.fromARGB(255, 41, 37, 37),
                  width: double.infinity,
                  height: 65,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                          color: Colors.black,
                          child: IconButton(
                              onPressed: () {
                                cubit.readScanner();
                              },
                              icon: const Icon(
                                Icons.qr_code,
                                color: Colors.white,
                              ))),
                      Expanded(
                        child: Container(
                          color: Colors.black,
                          child: TextFormField(
                            controller: qrCode,
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.red,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: "Search item or category",
                                hintStyle:
                                    const TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: ConditionalBuilder(
                  condition: true,
                  fallback: (context) => const Icon(
                    Icons.list,
                    size: 50,
                    color: Colors.white,
                  ),
                  builder: (context) => ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: cubit.makePrice.isNotEmpty,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color.fromARGB(255, 41, 37, 37),
                              ),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.location_city,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  cubit.makePrice.forEach((element) {
                                    List<Map<String, dynamic>> makePriceCity =
                                        [];
                                    if (cubit.makePrice[index]["city"] ==
                                        cubit.makePrice[index]["city"]) {
                                      makePriceCity.add(cubit.makePrice[index]);
                                      push(
                                          context: context,
                                          widget: Show(
                                              index: index,
                                              makePriceCity: makePriceCity));
                                    }
                                  });
                                },
                                title: Text(
                                  cubit.makePrice[index]["city"],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 5,
                          ),
                      itemCount: cubit.makePrice.length),
                )),
              ],
            ),
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //     backgroundColor: const Color.fromARGB(255, 41, 37, 37),
          //     unselectedItemColor: Colors.white,
          //     selectedItemColor: Colors.white,
          //     onTap: (i) {},
          //     items: const [
          //       BottomNavigationBarItem(
          //           icon: Icon(Icons.notifications), label: "Notification"),
          //       BottomNavigationBarItem(
          //           icon: Icon(Icons.category), label: "Categories"),
          //     ]),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.red,
            heroTag: "add",
            focusColor: const Color.fromARGB(255, 194, 44, 34),
            onPressed: () {
              push(context: context, widget: AddBranches());
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
      listener: (context, state) {
        if (state is PriceScannerState) {
          // qrCode.text = state.scanner!;
          // print(qrCode.text);
        }
      },
    );
  }
}
