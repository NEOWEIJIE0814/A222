class Cart {
  String? cartid;
  String? itemId;
  String? itemName;
  String? cartQty;
  String? cartPrice;
  String? userId;
  String? barterId;
  String? cartDate;
  String? barterStatus;

  Cart({
    this.cartid,
    this.itemId,
    this.itemName, 
    this.cartQty, 
    this.cartPrice, 
    this.userId, 
    this.barterId,
    this.cartDate,
    this.barterStatus,
    });

  Cart.fromJson(Map<String, dynamic> json) {
    cartid = json['cart_id'];
    itemId = json['item_id'];
    itemName = json['item_name'];
    cartQty = json['cart_qty'];
    cartPrice = json['cart_price'];
    userId = json['user_id'];
    barterId = json['barter_id'];
    cartDate = json['cart_date'];
    barterStatus = json['barter_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = cartid;
    data['item_id'] = itemId;
    data['item_name'] = itemName;
    data['cart_qty'] = cartQty;
    data['cart_price'] = cartPrice;
    data['user_id'] = userId;
    data['barter_id'] = barterId;
    data['cart_date'] = cartDate;
    data['barter_status'] = barterStatus;
    return data;
  }
}
