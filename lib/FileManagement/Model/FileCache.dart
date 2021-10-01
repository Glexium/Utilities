class FileCache
{
	int _id=-1;
	String _url='', _updatedAt ='', _name='';

	FileCache();

	set setId (int id) => { _id = id };
	set setURL(String url) => { _url = url };
	set setName(String name) => { _name = name };
	set setUpdatedAt(String updatedAt) => { _updatedAt = updatedAt };
	int get getId => _id;
	String get getName => _name;
	String get getUpdatedAt => _updatedAt;
	String get getURL => _url;

	Map toJson() => {
		'id': _id,
		'url': _url,
		'name': _name,
		'updatedAt': _updatedAt,
	};

	FileCache.fromJson(Map<String, dynamic> json)
			: _id = json['id'],
				_url = json['url'],
				_name = json['name'],
				_updatedAt = json['updateAt'];
}