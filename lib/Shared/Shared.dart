//Copyright (c) 2019 Ajiboye Temitope

//This work is licensed under the terms of the MIT license.
//For a copy, license that can be found in the NOTICES file.

//import 'package:gson/gson.dart'; gson: ^0.1.4
import 'package:shared_preferences/shared_preferences.dart';

enum SharedType { Boolean, Double, Integer, StringVal }

//based on shared_preference_project
class StorageUtil
{
	static StorageUtil _storageUtil;
	static SharedPreferences _preferences;

	static Future getInstance() async {
		if (_storageUtil == null) {
			// keep local instance till it is fully initialized.
			var secureStorage = StorageUtil._();
			await secureStorage._init();
			_storageUtil = secureStorage;
		}
		return _storageUtil;
	}
	StorageUtil._();
	Future _init() async {
		_preferences = await SharedPreferences.getInstance();
	}
	// get string
	static String getString(String key, {String defValue = ''}) {
		if (_preferences == null) return defValue;
		return _preferences.getString(key) ?? defValue;
	}
	// put string
	static Future putString(String key, String value) {
		if (_preferences == null) return null;
		return _preferences.setString(key, value);
	}

	/*
	static Future addGsonPreference(String key, Object value) async
	{
		if (_preferences == null) await getInstance();
		return _preferences.setString(value, Gson().decode(value));
	}

	static String getGsonPreference(String key, {String defValue = '{}'})
	{
		if (_preferences == null) return defValue;
		return Gson().decode(_preferences.getString(key) ?? defValue);
	}*/

	static Future addPreference(String name, SharedType type, Object value) async
	{
		if (_preferences == null) await getInstance();
		switch (type) {
			case SharedType.Boolean:
				return await _preferences.setBool(name, value);
			case SharedType.Double:
				return await _preferences.setDouble(name, value);
			case SharedType.Integer:
				return await _preferences.setInt(name, value);
			case SharedType.StringVal:
				return await _preferences.setString(name, value);
		}
	}

	static Future<Object> getPreference(String name, SharedType type) async
	{
		if (_preferences == null) await getInstance();
		Object obj;
		switch (type) {
			case SharedType.Boolean:
				obj = _preferences.getBool(name);
				break;
			case SharedType.Double:
				obj =  _preferences.getDouble(name);
				break;
			case SharedType.Integer:
				obj = _preferences.getInt(name);
				break;
			case SharedType.StringVal:
				obj = _preferences.getString(name);
				break;
		}
		return obj;
	}

	static Future clearPreferences() async
	{
		if (_preferences == null) getInstance();
		await _preferences.clear();
	}
}