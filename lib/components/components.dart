import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

void pushReplacement({required BuildContext context, required Widget widget}) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

void push({required BuildContext context, required Widget widget}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

Widget onBoarding(
    {required IconData icon, required String title, required String text}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        icon,
        size: 130,
        color: const Color.fromARGB(255, 133, 19, 11),
      ),
      const SizedBox(
        height: 30,
      ),
      Text(
        title,
        style: const TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 15,
      ),
      Container(
        width: 380,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
    ],
  );
}

Widget text({required String text}) {
  return Text(
    text,
    style: const TextStyle(
        color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
  );
}

Widget textFromField(
    {bool hint = false,
    required TextEditingController controller,
    String? text}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    color: const Color.fromARGB(255, 41, 37, 37),
    child: TextFormField(
      controller: controller,
      cursorColor: Colors.red,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          hintText: text,
          hintStyle: const TextStyle(color: Colors.white),
          border: InputBorder.none,
          prefixStyle: const TextStyle(color: Colors.grey),
          prefixText: hint ? "optional" : null),
    ),
  );
}

Widget button({required Function() function}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.red, borderRadius: BorderRadius.circular(5)),
    child: MaterialButton(
        onPressed: function,
        child: const Text(
          "Save",
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        )),
  );
}

Widget takeImage(
    {required String text,
    required IconData icon,
    required Function() function}) {
  return InkWell(
    onTap: function,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 5,
        ),
        Icon(
          icon,
          size: 34,
          color: Colors.red,
        )
      ],
    ),
  );
}

Widget listTile(
    {required Function() function,
    required String sale,
    required String item,
    required String size}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: const Color.fromARGB(255, 41, 37, 37),
    ),
    child: ListTile(
      onTap: function,
      leading: Text(
        "$sale\$",
        style: const TextStyle(
            color: Colors.yellowAccent,
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item,
            style: const TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            "Size/Weight: $size",
            style: const TextStyle(
                color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}

Widget container({
  required Uint8List file,
  required String item,
  required String category,
  required String size,
  required String quantity,
  required String cost,
  required String sale,
  required String description,
}) {
  return Container(
    width: double.infinity,
    height: 400,
    child: Column(
      children: [
        Container(
          color: Colors.red,
          width: double.infinity,
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Share.share(item, subject: category);
                  },
                  child: const Icon(
                    Icons.share,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const Icon(
                  Icons.list,
                  color: Colors.white,
                  size: 22,
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 95,
            height: 95,
            child: Image.memory(
              file,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          item,
          style: const TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          category,
          style: const TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const Divider(
                color: Colors.red,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    size,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Size",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    quantity,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Quantity",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cost,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Cost Price",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    sale,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Sale Price",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    description,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Descrption",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Divider(
                color: Colors.red,
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget containerExport({
  required Function() functionPdf,
  required Function() functionExcel,
}) {
  return Container(
    width: double.infinity,
    color: Colors.black,
    height: 400,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
            onTap: functionPdf,
            child: const Icon(
              Icons.picture_as_pdf,
              size: 120,
              color: Colors.red,
            )),
        InkWell(
            onTap: functionExcel,
            child: const Icon(
              Icons.file_copy,
              size: 120,
              color: Colors.green,
            )),
      ],
    ),
  );
}
