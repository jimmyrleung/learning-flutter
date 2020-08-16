import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';

class NewsDbProvider {
  Database db;

  init() async {
    // return a reference to a folder in our mobile devices
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // join the paths to generate the db path
    final path = join(documentsDirectory.path, 'items.db');

    // Tries to either create the db (if not exists) or open it (if exists)
    db = await openDatabase(path,
        version: 1, // If we change our db we can update the version
        onCreate: (Database newDb, int version) {
      // here we can do a little setup in our recently created db
      // it runs only in the first time that the user opens our app
      // """ allows you to create a multiline string
      newDb.execute(""" 
          CREATE TABLE items (
            id INTEGER PRIMARY KEY,
            type TEXT,
            by TEXT,
            time INTEGER,
            text TEXT,
            parent INTEGER,
            kids BLOB,
            dead INTEGER,
            deleted INTEGER
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER
          )
        """);
    });
  }

  fetchItem(int id) async {
    final maps = await db.query('items',
        columns:
            null, // to fetch all the columns we set null instead of an array of string
        where: "id = ?",
        whereArgs: [id] // these will be sanitized to prevent sql injection
        );

    if (maps.length > 0) {
      ItemModel.fromDb(maps.first);
    }

    // nothing has been found
    return null;
  }

  // We won't wait for the item to be added, so we are not
  // going to mark it as async
  addItem(ItemModel item) {
    db.insert('items', item.toMapForDb());
  }
}
