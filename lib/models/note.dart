import 'package:flutter/material.dart';

class Note {
  int? _id;
  String? _title;
  String? _description;
  String? _dateCreated;
  String? _dateModified;
  String? _state;

  Note(this._title, this._dateCreated, this._dateModified, this._state,
      [this._description]);

  Note.withId(
      this._id, this._title, this._dateCreated, this._dateModified, this._state,
      [this._description]);

  int? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get dateCreated => _dateCreated;
  String? get dateModified => _dateModified;
  String? get state => _state;

  set title(String? newTitle) {
    if (newTitle!.length <= 25) {
      this._title = newTitle;
    } else {
      debugPrint("Title exceeds the maximun allowed length of title.");
    }
  }

  set description(String? newDescription) {
    if (newDescription!.length <= 255) {
      this._description = newDescription;
    } else {
      debugPrint("Title exceeds the maximun allowed length.");
    }
  }

  set state(String? newState) {
    if (newState! == 'In-Progress' || newState == 'Completed') {
      this._state = newState;
    }
  }

  set dateCreated(String? newDateCreated) {
    this._dateCreated = newDateCreated;
  }

  set dateModified(String? newDateModified) {
    this._dateModified = newDateModified;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['state'] = _state;
    map['dateCreated'] = _dateCreated;
    map['dateModified'] = _dateModified;

    return map;
  }

  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._state = map['state'];
    this._dateCreated = map['dateCreated'];
    this._dateModified = map['dateModified'];
  }
}
