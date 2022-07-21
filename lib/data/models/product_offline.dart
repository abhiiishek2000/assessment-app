class Product {


  Product({this.prodImage,this.prodId,this.prodPrice,this.prodName,this.user_id,this.quantity});
  String? prodImage;
  String? prodId;
  String? prodPrice;
  String? prodName;
  int? user_id;
  String? quantity;


  Product.fromMap(Map<String, dynamic> map) {
    prodImage = map['prodImage'];
    prodId = map['prodId'];
    prodPrice = map['prodPrice'];
    prodName = map['prodName'];
    user_id = map['user_id'];
    quantity = map['quantity'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{"prodImage": prodImage, "prodId": prodId,'prodPrice':prodPrice,'prodName':prodName,'user_id':user_id,'quantity':quantity};
    return map;
  }
}