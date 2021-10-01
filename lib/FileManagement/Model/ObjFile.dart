import 'package:utilities/FileManagement/FileManagement.dart';

/// Class used for [FileManagement]
class ObjFile
{
	int _index=-1, _fileId=-1;
	String _fileName='', _fileUrl='', _type='';
	bool _isImage=false, _localUrl=false, _isDeletable=false;

	ObjFile();

	set setIndex(int index) => { _index = index };
	set setFileId(int fileId) => { _fileId = fileId };
	set setFileName(String fileName) => { _fileName = fileName };
	set setFileUrl(String fileUrl) => { _fileUrl = fileUrl };
	set setType(String type) => { _type = type };
	set setIsImage(bool isImage) => { _isImage = isImage };
	set setLocalUrl(bool localUrl) => { _localUrl = localUrl };
	set setIsDeletable(bool isDeletable) => { _isDeletable = isDeletable };

	int get getIndex => _index;
	int get getFileId => _fileId;
	String get getFileName => _fileName;
	String get getFileUrl => _fileUrl;
	String get getType => _type;
	bool get isImage => _isImage;
	bool get isLocalUrl => _localUrl;
	bool get isDeletable => _isDeletable;

	Map toJson() => {
		'index': _index,
		'fileId': _fileId,
		'fileName': _fileName,
		'fileUrl': _fileUrl,
		'type': _type,
		'isImage': _isImage,
		'localUrl': _localUrl,
		'isDeletable': _isDeletable
	};

	ObjFile.fromJson(Map<String, dynamic> json)
			: _index = json['index'],
				_fileId = json['fileId'],
				_fileName = json['fileName'],
				_fileUrl = json['fileUrl'],
				_type = json['type'],
				_isImage = json['isImage'],
				_localUrl = json['localUrl'],
				_isDeletable = json['isDeletable'];
}