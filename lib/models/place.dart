
import 'package:uuid/uuid.dart'; // this for generate id


const uuid = Uuid();
// just create pojo objest for 
class Place {
  Place({required this.title}) : id = uuid.v4();

  final String id;
  final String title;
}