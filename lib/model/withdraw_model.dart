class WithdrawModel {
  int? id;
  String? amount;
  String? bankName;
  String? accName;
  String? accNumber;
  String? routingNumber;

  WithdrawModel({
    this.id,
    this.accName,
    this.accNumber,
    this.amount,
    this.bankName,
    this.routingNumber,
  });

  WithdrawModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['price'];
    bankName = json['bank_name'];
    accName = json['account_name'];
    accNumber = json['account_number'];
    routingNumber = json['routing_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.amount;
    data['bank_name'] = this.bankName;
    data['account_name'] = this.accName;
    data['account_number'] = this.accNumber;
    data['routing_number'] = this.routingNumber;
    return data;
  }
}
