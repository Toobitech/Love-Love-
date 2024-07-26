class CallLogsModel {
  int? id;
  String? title;
  String? duraion;
  String? time;

  CallLogsModel({
    this.id,
    this.title,
    this.duraion,
    this.time,
  });

  CallLogsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['price'];
    duraion = json['bank_name'];
    time = json['account_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.title;
    data['bank_name'] = this.duraion;
    data['account_name'] = this.time;
    return data;
  }
}
