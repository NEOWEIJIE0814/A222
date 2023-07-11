class Token {
  String? tokenid;
  String? userid;
  String? qty;
  String? date;
  String? status;

  Token({this.tokenid, this.userid, this.qty, this.date, this.status});

  Token.fromJson(Map<String, dynamic> json) {
    tokenid = json['tokenid'];
    userid = json['userid'];
    qty = json['qty'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tokenid'] = this.tokenid;
    data['userid'] = this.userid;
    data['qty'] = this.qty;
    data['date'] = this.date;
    data['status'] = this.status;
    return data;
  }
}
