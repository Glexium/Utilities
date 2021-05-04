import 'dart:io';

import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:utilities/FileManagement/Model/FileCache.dart';
import 'database/Entity/EFile.dart';
import 'database/database.dart';

/// Class for file management
class FileManagement
{

	/// Returns a Future with the app document's path+file.
	static Future<String> getFilePath(String fileName) async {
		Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
		String appDocumentsPath = appDocumentsDirectory.path;
		String filePath = '$appDocumentsPath/$fileName';
		return filePath;
	}

	/// This creates a text file in the app document directory.
	static void saveTextFile(String fileName, String content) async {
		File file = File(await getFilePath(fileName));
		file.writeAsString(content);
	}

	/// This creates a file of bytes in the app document directory.
	///
	/// This file can be of any format, if the [fileName] already exist it delete it
	/// and then creates a new file.
	static void saveFile(String fileName, List<int> fileBytes) async {
		deleteFile(fileName);
		File file = File(await getFilePath(fileName));
		await file.writeAsBytes(fileBytes);
	}

	/// This deletes a file in the app document directory.
	///
	/// It checks if [fileName] exist in the app document directory and then delete it.
	static Future<void> deleteFile(String fileName) async {
		try {
			File file = File(await getFilePath(fileName));
			if(file.existsSync())
				await file.delete();
		} catch (e) {

		}
	}

	/// This is only to print the content of a file in the app document directory.
	static void readTextFile(String fileName) async {
		File file = File(await getFilePath(fileName));
		String fileContent = await file.readAsString();
		print('File Content: $fileContent');
	}

	/// This creates a cache for files so it doesn't need to keep downloading the same file on each visit.
	///
	/// The list of files must contain an [FileCache] structure and an existing database
	/// to work correctly, the way this works is as follow:
	/// - Check each file's id exist in the database.
	/// - If not, insert it's data in the DB and save the file into the app document directory,
	///   finally it sets the file's url to a local directory.
	/// - If exist, checks the [updatedAt] of both, the db and file,
	///   -- If both are the same then just get the file's local directory.
	///   -- If not, updates DB and file in the local directory.
	///
	/// Very useful to speed up loading times.
	/// Meant to be used with an API that keeps track of files.
	static Future<List<dynamic>> getLocalCacheFiles(List<dynamic> files,
			{String dataBaseName = 'app_database.db', String ext = '.png'}) async {
		final db = await $FloorAppDatabase.databaseBuilder(dataBaseName).build();
		final cacheDao = db.getCache;
		for (dynamic file in files) {
			final data = await cacheDao.findFileById(file.getFileCache.getId);
			if (data == null) {
				final fileCache = EFile(file.getFileCache.getId, file.getFileCache.getName,
						file.getFileCache.getUpdatedAt);
				cacheDao.insertFile(fileCache);
				var response = await get(Uri.parse(file.getFileCache.getURL));
				FileManagement.saveFile(
						file.getFileCache.getId.toString() + ext, response.bodyBytes);
			} else {
				if (data.updatedAt != file.getFileCache.getUpdatedAt) {
					var response = await get(Uri.parse(file.getFileCache.getURL));
					EFile update =
					EFile(data.id, data.name, file.getFileCache.getUpdatedAt);
					await cacheDao.updateFileFromCache(update);
					FileManagement.saveFile(
							file.getFileCache.getId.toString() + ext, response.bodyBytes);
				}
			}
			String originalUrl = file.getFileCache.getURL;
			file.getFileCache.setURL = await FileManagement
					.getFilePath(file.getFileCache.getId.toString() + ext);
			if(!File(file.getFileCache.getURL).existsSync())
			{
				var response = await get(Uri.parse(originalUrl));
				FileManagement.saveFile(
						file.getFileCache.getId.toString() + ext, response.bodyBytes);
				file.getFileCache.setURL = await FileManagement
						.getFilePath(file.getFileCache.getId.toString() + ext);
			}
		}
		return files;
	}

	/// This creates a cache for files so it doesn't need to keep downloading the same file on each visit.
	///
	/// The file must contain an [FileCache] structure and an existing database
	/// to work correctly, the way this works is as follow:
	/// - Check if the file's id exist in the database.
	/// - If not, insert it's data in the DB and save the file into the app document directory,
	///   finally it sets the file's url to a local directory.
	/// - If exist, checks the [updatedAt] of both, the db and file,
	///   -- If both are the same then just get the file's local directory.
	///   -- If not, updates DB and file in the local directory.
	///
	/// Very useful to speed up loading times.
	/// Meant to be used with an API that keeps track of files.
	static Future<FileCache> getLocalCacheFile(FileCache file,
			{String dataBaseName = 'app_database.db'}) async {
		final db = await $FloorAppDatabase.databaseBuilder(dataBaseName).build();
		final cacheDao = db.getCache;
		final data = await cacheDao.findFileById(file.getId);
		if (data == null) {
			final fileCache = EFile(file.getId, file.getName, file.getUpdatedAt);
			cacheDao.insertFile(fileCache);
			var response = await get(Uri.parse(file.getURL));
			FileManagement.saveFile(file.getName, response.bodyBytes);
		} else {
			if (data.updatedAt != file.getUpdatedAt) {
				var response = await get(Uri.parse(file.getURL));
				cacheDao.updateFileFromCache(data);
				FileManagement.saveFile(file.getName, response.bodyBytes);
			}
			else if(!File(file.getURL).existsSync())
			{
				var response = await get(Uri.parse(file.getURL));
				FileManagement.saveFile(
						file.getName, response.bodyBytes);
			}
		}
		String originalUrl = file.getURL;
		file.setURL = await FileManagement.getFilePath(file.getName);
		if(!File(file.getURL).existsSync())
		{
			var response = await get(Uri.parse(originalUrl));
			FileManagement.saveFile(file.getName, response.bodyBytes);
			file.setURL = await FileManagement.getFilePath(file.getName);
		}
		return file;
	}

	/// This deletes a file from the app document directory and local database.
	static Future<int> deleteCacheFile(int id,
			{String dataBaseName = 'app_database.db'}) async {
		final db = await $FloorAppDatabase.databaseBuilder(dataBaseName).build();
		final cacheDao = db.getCache;
		final data = await cacheDao.findFileById(id);
		return await cacheDao.deleteFileFromCache(data);
	}
}