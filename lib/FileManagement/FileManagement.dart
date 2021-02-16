import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileManagement
{

	Future<String> getFilePath(String fileName) async {
		Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
		String appDocumentsPath = appDocumentsDirectory.path;
		String filePath = '$appDocumentsPath/$fileName';
		return filePath;
	}

	void saveTextFile(String fileName, String content) async {
		File file = File(await getFilePath(fileName));
		file.writeAsString(content);
	}

	void saveFile(String fileName, List<int> fileBytes) async {
		deleteFile(fileName);
		File file = File(await getFilePath(fileName));
		await file.writeAsBytes(fileBytes);
	}

	Future<void> deleteFile(String fileName) async {
		try {
			File file = File(await getFilePath(fileName));
			if(file.existsSync())
				await file.delete();
		} catch (e) {

		}
	}

	void readTextFile(String fileName) async {
		File file = File(await getFilePath(fileName));
		String fileContent = await file.readAsString();
		print('File Content: $fileContent');
	}
}