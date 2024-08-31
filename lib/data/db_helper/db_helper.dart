import 'package:product_catalog_app/utils/string_const.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DBHelper {
  //static const DBHelper _dbHelper = DBHelper._dbHelper;
  DBHelper();


  String tableName = AppStringConst.tableName;
  String id = AppStringConst.productId;
  String name = AppStringConst.productName;
  String description = AppStringConst.productDescription;
  String images = AppStringConst.productImages;
  String price = AppStringConst.productPrice;
  String category = AppStringConst.productCategory;
  String rating = AppStringConst.rating;
  String createdAt = AppStringConst.createdAt;
  String updatedAt = AppStringConst.updatedAt;
  
  Future<Database> get database async{
    
    return await initDatabase();
  }

  Future<void> deleteDatabase1() async{
     String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'product_catalog.db');
    await deleteDatabase(path);
  }
  
  Future<Database> initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'product_catalog.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $tableName(
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $name TEXT NOT NULL,
            $description TEXT NOT NULL,
            $images TEXT NOT NULL,
            $price REAL NOT NULL,
            $rating REAL NOT NULL,
            $category TEXT NOT NULL,
            $createdAt TEXT NOT NULL,
            $updatedAt TEXT NOT NULL
    )
    ''');
  }
}
