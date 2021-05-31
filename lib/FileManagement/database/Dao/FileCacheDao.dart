import 'package:floor/floor.dart';
import 'package:utilities/FileManagement/database/Entity/EFile.dart';

@dao
abstract class FileCacheDao {
	@Query('SELECT * FROM EFile')
	Future<List<EFile>> getFileCache();

	@Query('SELECT * FROM EFile WHERE id = :id')
	Future<EFile?> findFileById(int id);

	@Query('SELECT * FROM EFile WHERE name = :name')
	Stream<EFile?> findFileByName(String name);

	@Query('DELETE FROM EFile WHERE id = :id')
	Stream<EFile?> deleteFileById(int id);

	@insert
	Future<void> insertFile(EFile eFile);

	@update
	Future<int> updateFileFromCache(EFile eFile);

	@delete
	Future<int> deleteFileFromCache(EFile eFile);
}