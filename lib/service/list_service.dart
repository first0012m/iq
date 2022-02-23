class ListData {
  ListData({
    required this.msg,
  });
  
  String msg;

  ListData.fromJson(Map<String, dynamic> json) : msg = json["msg"];
}
