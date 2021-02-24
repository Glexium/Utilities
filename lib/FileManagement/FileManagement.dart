import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Class for file management
class FileManagement
{

	/// Returns a Future with the app document's path+file.
	Future<String> getFilePath(String fileName) async {
		Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
		String appDocumentsPath = appDocumentsDirectory.path;
		String filePath = '$appDocumentsPath/$fileName';
		return filePath;
	}

	/// This creates a text file in the app document directory.
	void saveTextFile(String fileName, String content) async {
		File file = File(await getFilePath(fileName));
		file.writeAsString(content);
	}

	/// This creates a file of bytes in the app document directory.
	///
	/// This file can be of any format, if the [fileName] already exist it delete it
	/// and then creates a new file.
	void saveFile(String fileName, List<int> fileBytes) async {
		deleteFile(fileName);
		File file = File(await getFilePath(fileName));
		await file.writeAsBytes(fileBytes);
	}

	/// This deletes a file in the app document directory.
	///
	/// It checks if [fileName] exist in the app document directory and then delete it.
	Future<void> deleteFile(String fileName) async {
		try {
			File file = File(await getFilePath(fileName));
			if(file.existsSync())
				await file.delete();
		} catch (e) {

		}
	}

	/// This is only to print the content of a file in the app document directory.
	void readTextFile(String fileName) async {
		File file = File(await getFilePath(fileName));
		String fileContent = await file.readAsString();
		print('File Content: $fileContent');
	}
}