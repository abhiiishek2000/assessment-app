class AddProduct {


  AddProduct({this.prodImage,this.prodId,this.prodPrice,this.prodName});
  String? prodImage;
  String? prodId;
  String? prodPrice;
  String? prodName;


  AddProduct.fromMap(Map<String, dynamic> map) {
    prodImage = map['prodImage'];
    prodId = map['prodId'];
    prodPrice = map['prodPrice'];
    prodName = map['prodName'];

  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{"prodImage": prodImage, "prodId": prodId,'prodPrice':prodPrice,'prodName':prodName};
    return map;
  }
}