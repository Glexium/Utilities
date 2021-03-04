import 'package:floor/floor.dart';

@entity
class EFile {
	@primaryKey
	final int id;
	final String name, updatedAt;

	EFile(this.id, this.name, this.updatedAt);
}