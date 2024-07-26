class PricingModel {
  int? id;
  final int userId;
  final String amount;
  final int mins;

  PricingModel({
    this.id,
    required this.userId,
    required this.amount,
    required this.mins,
  });
  factory PricingModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return PricingModel(
      id: json['id'],
      userId: json['user_id'],
      amount: json['amount'],
      mins: json['mins'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'amount': amount,
      'mins': mins,
    };
  }
}
