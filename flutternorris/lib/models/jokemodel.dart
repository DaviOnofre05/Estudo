class JokeModel {
  List<String>? categories;
  String? createdAt;
  String? iconUrl;
  String? id;
  String? updatedAt;
  String? url;
  String? value;

  JokeModel({
    this.categories,
    this.createdAt,
    this.iconUrl,
    this.id,
    this.updatedAt,
    this.url,
    this.value
  });

  JokeModel.fromJson(Map<String, dynamic> json) {
    categories = json['categories'].cast<String>();
    createdAt = json['created_at'];
    iconUrl = json['icon_url'];
    id = json['id'];
    updatedAt = json['updated_at'];
    url = json['url'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categories'] = categories;
    data['created_at'] =  createdAt;
    data['icon_url'] = iconUrl;
    data['id'] = id;
    data['updated_at'] = updatedAt;
    data['url'] = url;
    data['value'] = value;
    return data;
  }
}