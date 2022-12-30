import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makeprice/layout/cubit/states.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class PriceCubit extends Cubit<PriceStates> {
  PriceCubit() : super(PriceInitialState());
  static PriceCubit get(context) => BlocProvider.of(context);
  String scanner = "";
  void readScanner() {
    FlutterBarcodeScanner.scanBarcode(
            "#ff6666", "Cancel", false, ScanMode.BARCODE)
        .then((value) {
      scanner = value;
      emit(PriceScannerState());
    });
  }

  String scannerNewItem = "";
  void readScannerNewItem() {
    FlutterBarcodeScanner.scanBarcode(
            "#e8091c", "Scan Code", true, ScanMode.BARCODE)
        .then((value) {
      scannerNewItem = value;
      print(scannerNewItem);
    }).catchError((e) {
      print("hi");

      print(e.toString());
    });
    emit(PriceNewItemScannerState(scanner: scannerNewItem));
  }

  String? saveFileShared;
  List<File> saveFile = [];

  File? file;
  var picker = ImagePicker();
  Future imageGallery() async {
    final gallery = await picker.pickImage(source: ImageSource.gallery);
    if (gallery != null) {
      file = File(gallery.path);
      Cropped(sourcePath: file!);
      emit(PriceImagePickerGallerySuccessState());
    } else {
      print("no phots");
      emit(PriceImagePickerGalleryErrorState());
    }
  }

  File? fileOfCamera;
  var pickerOfCamera = ImagePicker();
  Future imageCamera() async {
    final camera = await pickerOfCamera.pickImage(source: ImageSource.camera);
    if (camera != null) {
      fileOfCamera = File(camera.path);
      Cropped(sourcePath: fileOfCamera!);
      print(camera.path);
      emit(PriceImagePickerCameraSuccessState());
    } else {
      print("no phots");
      emit(PriceImagePickerCameraErrorState());
    }
  }

  CroppedFile? croppedFile;
  File? croppedImage;

  Future Cropped({required File sourcePath}) async {
    croppedFile = await ImageCropper().cropImage(sourcePath: sourcePath.path);
    if (croppedFile == null) {
      return null;
    }
    croppedImage = File(croppedFile!.path);
    saveFile.add(croppedImage!);
    convertImageToBase64(croppedImage: croppedImage!);

    emit(PriceImageCropState());
  }

  Uint8List? byte;
  void convertBase64ToImage({required String base64}) {
    byte = base64Decode(base64);
    print(bytes);
    emit(PriceConvertToImageState());
  }

  String? base64Image;
  void convertImageToBase64({required File croppedImage}) {
    final bytes = croppedImage.readAsBytesSync();
    base64Image = base64Encode(bytes);
    // print(base64Image);
    emit(PriceConvertToBase64State());
  }

  Database? db;
  void create() {
    openDatabase("pricee.db", version: 1, onCreate: (database, version) {
      print("database created");
      database
          .execute(
              "CREATE TABLE tasks (id INTEGER PRIMARY KEY , categories TEXT , item TEXT , size TEXT , quantity TEXT,sale TEXT,cost TEXT,description TEXT,code TEXT,pic TEXT,city TEXT,no TEXT)")
          .then((value) {
        print("success");
      }).catchError((onError) {
        print(onError.toString());
      });
    }, onOpen: (database) {
      getData(database);
    }).then((value) {
      db = value;
      emit(PriceSqfliteCreateState());
    });
  }

  void insert({
    required String categories,
    required String item,
    required String size,
    required String quantity,
    required String code,
    required String description,
    required String sale,
    required String cost,
    required String pic,
    required String city,
    required String no,
  }) {
    db?.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks (categories,item,size,quantity,sale,cost,description,code,pic,city,no)VALUES("$categories","$item","$size","$quantity","$sale","$cost","$description","$code","$pic","$city","$no")')
          .then((value) {
        // print("$value");
      }).catchError((error) {
        print(error.toString());
      });
    }).then((value) {
      emit(PriceSqfliteInsertState());
      getData(db);
    });
  }

  List<Map<String, dynamic>> makePrice = [];
  void getData(database) {
    database.rawQuery('SELECT * FROM tasks').then((value) {
      makePrice = value;
      print(makePrice);
      emit(PriceSqfliteGetState());
    });
  }

  // void updateData({
  //   required String status,
  //   required int id,
  // }) {
  //   db!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
  //       ['$status', id]).then((value) {
  //     emit(AppCubitUpdate());
  //     // getData(db);
  //   });
  // }
//  Database? data;
//   void createCategory() {
//     openDatabase("category.db", version: 1, onCreate: (database, version) {
//       print("database created");
//       database
//           .execute(
//               "CREATE TABLE tasks (id INTEGER PRIMARY KEY , categories TEXT , item TEXT , size TEXT , quantity TEXT,sale TEXT,cost TEXT,description TEXT,code TEXT,pic TEXT)")
//           .then((value) {
//         print("success");
//       }).catchError((onError) {
//         print(onError.toString());
//       });
//     }, onOpen: (database) {
//       getData(database);
//       print(database);
//     }).then((value) {
//       db = value;
//       emit(PriceSqfliteCategoryCreateState());
//     });
//   }

//   void insertCategory({
//     required String categories,
//     required String item,
//     required String size,
//     required String quantity,
//     required String code,
//     required String description,
//     required String sale,
//     required String cost,
//     required String pic,
//   }) {
//     db?.transaction((txn) {
//       return txn
//           .rawInsert(
//               'INSERT INTO tasks (categories,item,size,quantity,sale,cost,description,code,pic)VALUES("$categories","$item","$size","$quantity","$sale","$cost","$description","$code","$pic")')
//           .then((value) {
//         // print("$value");
//       }).catchError((error) {
//         print(error.toString());
//       });
//     }).then((value) {
//       emit(PriceSqfliteCategoryInsertState());
//       getData(db);
//     });
//   }

//   List<Map<String, dynamic>> makePriceCategory = [];
//   void getDataCategory(database) {
//     database.rawQuery('SELECT * FROM tasks').then((value) {
//       makePriceCategory = value;

//       emit(PriceSqfliteCategoryGetState());
//     });
//   }

  // void deleteData({required int id}) {
  //   db!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
  //     emit(PriceSqfliteDeleteState());
  //   });
  // }

  PdfDocument? pdf;
  List<int> bytes = [];
  Future<void> createPdf({
    required String item,
    required String catogery,
  }) async {
    pdf = PdfDocument();
    final add = pdf!.pages.add();
    add.graphics.drawString(
      item,
      PdfStandardFont(PdfFontFamily.helvetica, 30),
    );

    bytes = await pdf!.save();
    pdf!.dispose();
    saveAndLaunch(bytes, "out.pdf");
  }

  Future<void> saveAndLaunch(List<int> bytes, String name) async {
    final path = (await getExternalStorageDirectory())!.path;
    File file = File("$path/$name");
    file.writeAsBytes(bytes, flush: true);
    OpenFile.open("$path/$name");
    emit(PricePdfSaveState());
  }

  Workbook? workbook;
  Future<void> createExcel({
    required String item,
    required String price,
  }) async {
    workbook = Workbook();
    final Worksheet worksheet = workbook!.worksheets[0];
    worksheet.getRangeByName("A1").setText(item);
    worksheet.getRangeByName("B1").setText(price);
    worksheet.getRangeByName("A2").setText("item 2");
    worksheet.getRangeByName("B2").setText("20\$");
    worksheet.getRangeByName("A3").setText("item 3");
    worksheet.getRangeByName("B3").setText("10\$");
    worksheet.getRangeByName("A4").setText("item 4");
    worksheet.getRangeByName("B4").setText("25\$");
    worksheet.getRangeByName("A5").setText("item 5");
    worksheet.getRangeByName("B5").setText("27\$");
    worksheet.getRangeByName("A6").setText("item 6");
    worksheet.getRangeByName("B6").setText("200\$");
    worksheet.getRangeByName("A7").setText("item 7");
    worksheet.getRangeByName("B7").setText("20\$");
    worksheet.getRangeByName("A8").setText("total");
    worksheet
        .getRangeByName("B8")
        .setText("${int.parse(price) + 20 + 10 + 25 + 27 + 200 + 20}");

    worksheet.getRangeByName("A9").setText("Date");
    worksheet
        .getRangeByName("B9")
        .setText(DateTime.now().toString().split(" ").first.toString());
    final List<int> bytes = workbook!.saveAsStream();
    workbook!.dispose();
    final String path = (await getApplicationSupportDirectory()).path;
    String name = "$path/out.xlsx";
    File file = File(name);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(name);
  }

  List<String> items = ["Uncategorized", "1", "2", "3"];
  String? item;
  void selectedItem(String i) {
    item = i;
    emit(PriceItemState());
  }
}
