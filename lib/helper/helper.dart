import 'package:cloud_firestore/cloud_firestore.dart';
//return a formatted data as a string

String formatDate(Timestamp timestamp){
  //time stamp is gotten from firebase so let's retrieve it and convert to string
  DateTime dateTime = timestamp.toDate();

  //get year
  String year = dateTime.year.toString();

  //get month
  String month = dateTime.month.toString();

  //get day
  String day = dateTime.day.toString();

  //format date
  String formattedData = '$day/$month/$year';

  return formattedData;

}
