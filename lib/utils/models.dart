import 'package:flutter/material.dart';
class User {
  String fullName;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String imageURL;

  User(
      this.fullName,
      this.email,
      this.phoneNumber,
      {this.imageURL,
        this.firstName,
        this.lastName}
      );
}
