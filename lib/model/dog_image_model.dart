// To parse this JSON data, do
//
//     final dogImageModel = dogImageModelFromJson(jsonString);

import 'dart:convert';

DogImageModel dogImageModelFromJson(String str) => DogImageModel.fromJson(json.decode(str));

String dogImageModelToJson(DogImageModel data) => json.encode(data.toJson());

class DogImageModel {
    DogImageModel({
        this.message,
        this.status,
    });

    String? message;
    String? status;

    factory DogImageModel.fromJson(Map<String, dynamic> json) => DogImageModel(
        message: json["message"] == null ? null : json["message"],
        status: json["status"] == null ? null : json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "status": status == null ? null : status,
    };
}
