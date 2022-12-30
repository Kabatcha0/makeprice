abstract class PriceStates {}

class PriceInitialState extends PriceStates {}

class PriceScannerState extends PriceStates {
  // String? scanner;
  // PriceScannerState({required this.scanner});
}

class PriceNewItemScannerState extends PriceStates {
  String? scanner;
  PriceNewItemScannerState({required this.scanner});
}

class PriceImagePickerGallerySuccessState extends PriceStates {}

class PriceImagePickerGalleryErrorState extends PriceStates {}

class PriceImagePickerCameraSuccessState extends PriceStates {}

class PriceImagePickerCameraErrorState extends PriceStates {}

class PriceImageCropState extends PriceStates {}

class PriceSqfliteCreateState extends PriceStates {}

class PriceSqfliteInsertState extends PriceStates {}

class PriceSqfliteGetState extends PriceStates {}

class PriceSqfliteCategoryCreateState extends PriceStates {}

class PriceSqfliteCategoryInsertState extends PriceStates {}

class PriceSqfliteCategoryGetState extends PriceStates {}

class PricePdfCreateState extends PriceStates {}

class PricePdfSaveState extends PriceStates {}

class PriceSqfliteDeleteState extends PriceStates {}

class PriceConvertToBase64State extends PriceStates {}

class PriceConvertToImageState extends PriceStates {}

class PriceItemState extends PriceStates {}
