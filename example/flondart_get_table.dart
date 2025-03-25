import 'package:flondart/flondart.dart';

main() async {
  FLONClient client = FLONClient('http://127.0.0.1:8888', 'v1');

  // Get Tables
  client.getTableRows('flon', 'flon', 'abihash').then((rows) => print(rows));
  client.getTableRow('flon', 'flon', 'abihash').then((row) => print(row));
}
