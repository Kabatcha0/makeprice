import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:makeprice/components/components.dart';
import 'package:makeprice/modules/newitem.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class AddBranches extends StatelessWidget {
  GlobalKey<SfSignaturePadState> skey = GlobalKey<SfSignaturePadState>();
  TextEditingController noOfEmployeesKey = TextEditingController();
  TextEditingController cityKey = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 41, 37, 37),
                  borderRadius: BorderRadius.circular(10)),
              child: SfSignaturePad(
                strokeColor: Colors.white,
                key: skey,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: textFromField(
                  controller: noOfEmployeesKey, text: "No.Employees"),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: textFromField(controller: cityKey, text: "City"),
            ),
            const SizedBox(height: 20),
            button(function: () {
              push(
                  context: context,
                  widget: NewItem(
                      noOfEmployees: noOfEmployeesKey.text,
                      city: cityKey.text));
            })
          ],
        ),
      )),
    );
  }
}
