class Cart {


  Cart({this.prodImage,this.prodPrice,this.prodName,this.quantity,this.prodId});
  String? prodImage;
  String? prodPrice;
  String? prodName;
  String? quantity;
  String? prodId;


  Cart.fromMap(Map<String, dynamic> map) {
    prodImage = map['prodImage'];
    prodPrice = map['prodPrice'];
    prodName = map['prodName'];
    quantity = map['quantity'];
    prodId = map ['prodId'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{"prodImage": prodImage,'prodPrice':prodPrice,'prodName':prodName,'quantity':quantity,'prodId':prodId,};
    return map;
  }
}