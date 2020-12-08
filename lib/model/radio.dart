import 'dart:convert';

import 'package:flutter/foundation.dart';

class Radios {
  final int id;
  final int order;
  final String name;
  final String tagline;
  final String color;
  final String description;
  final String url;
  final String category;
  final String icon;
  final String image;
  final String lang;
  const Radios({
    this.id,
    this.order,
    this.name,
    this.tagline,
    this.color,
    this.description,
    this.url,
    this.category,
    this.icon,
    this.image,
    this.lang,
  });

  Radios copyWith({
    int id,
    int order,
    String name,
    String tagline,
    String color,
    String description,
    String url,
    String category,
    String icon,
    String image,
    String lang,
  }) {
    return Radios(
      id: id ?? this.id,
      order: order ?? this.order,
      name: name ?? this.name,
      tagline: tagline ?? this.tagline,
      color: color ?? this.color,
      description: description ?? this.description,
      url: url ?? this.url,
      category: category ?? this.category,
      icon: icon ?? this.icon,
      image: image ?? this.image,
      lang: lang ?? this.lang,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order': order,
      'name': name,
      'tagline': tagline,
      'color': color,
      'description': description,
      'url': url,
      'category': category,
      'icon': icon,
      'image': image,
      'lang': lang,
    };
  }

  factory Radios.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Radios(
      id: map['id'],
      order: map['order'],
      name: map['name'],
      tagline: map['tagline'],
      color: map['color'],
      description: map['description'],
      url: map['url'],
      category: map['category'],
      icon: map['icon'],
      image: map['image'],
      lang: map['lang'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Radios.fromJson(String source) => Radios.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Radios(id: $id, order: $order, name: $name, tagline: $tagline, color: $color, description: $description, url: $url, category: $category, icon: $icon, image: $image, lang: $lang)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Radios &&
        o.id == id &&
        o.order == order &&
        o.name == name &&
        o.tagline == tagline &&
        o.color == color &&
        o.description == description &&
        o.url == url &&
        o.category == category &&
        o.icon == icon &&
        o.image == image &&
        o.lang == lang;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        order.hashCode ^
        name.hashCode ^
        tagline.hashCode ^
        color.hashCode ^
        description.hashCode ^
        url.hashCode ^
        category.hashCode ^
        icon.hashCode ^
        image.hashCode ^
        lang.hashCode;
  }
}

class RadioList {
  final List<Radios> radios;
  const RadioList({
    this.radios,
  });

  RadioList copyWith({
    List<Radios> radios,
  }) {
    return RadioList(
      radios: radios ?? this.radios,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'radios': radios?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory RadioList.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RadioList(
      radios: List<Radios>.from(map['radios']?.map((x) => Radios.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RadioList.fromJson(String source) =>
      RadioList.fromMap(json.decode(source));

  @override
  String toString() => 'RadioList(radios: $radios)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RadioList && listEquals(o.radios, radios);
  }

  @override
  int get hashCode => radios.hashCode;
}
