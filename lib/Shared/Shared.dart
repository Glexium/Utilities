//Copyright (c) 2019 Ajiboye Temitope

//This work is licensed under the terms of the MIT license.
//For a copy, license that can be found in the NOTICES file.

//import 'package:gson/gson.dart'; gson: ^0.1.4
import 'package:shared_preferences/shared_preferences.dart';

/// Types of data available
enum SharedType { Boolean, Double, Integer, StringVal }

//based on shared_preference_project
/// [StorageUtil] is for stored preferences and read them.
class StorageUtil
{
	static StorageUtil? _storageUtil;
	static SharedPreferences? _preferences;

	/// It gets a 'Future' instance of [StorageUtil]
	///
	/// It check if [_storageUtil] exist, if not creates one and then return it.
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

	/// Returns a string of a [key] stored.
	///
	/// If this [key] is not found it returns a default value.
	static String getString(String key, {String defValue = ''}) {
		if (_preferences == null) return defValue;
		return _preferences!.getString(key) ?? defValue;
	}

	/// Returns a future after stored a [key] with a [value]
	///
	/// It returns a Future to give time to stored the data.
	static Future? putString(String key, String value) {
		if (_preferences == null) return null;
		return _preferences!.setString(key, value);
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

	/// Returns a Future after stored a preference.
	///
	/// To add a preference it requires [name], [type] and [value],
	/// if there is no instance it wait for [getInstance] to create one, because
	/// if it doesn't wait it will crash with a [NullPointerException]
	/// then it set [name] and [value].
	static Future addPreference(String name, SharedType type, dynamic value) async
	{
		if (_preferences == null) await getInstance();
		switch (type) {
			case SharedType.Boolean:
				return await _preferences!.setBool(name, value);
			case SharedType.Double:
				return await _preferences!.setDouble(name, value);
			case SharedType.Integer:
				return await _preferences!.setInt(name, value);
			case SharedType.StringVal:
				return await _preferences!.setString(name, value);
		}
	}

	/// Returns a Future with a 'dynamic' value of a preference.
	///
	/// It requires [name] and [type] of the preference.
	/// if there is no instance it wait for [getInstance] to create one, because
	/// if it doesn't wait it will crash with a [NullPointerException],
	/// it used future as a return value in case of [_preferences] is not initialized.
	static Future<dynamic> getPreference(String name, SharedType type) async
	{
		if (_preferences == null) await getInstance();
		dynamic obj;
		switch (type) {
			case SharedType.Boolean:
				obj = _preferences!.getBool(name);
				break;
			case SharedType.Double:
				obj =  _preferences!.getDouble(name);
				break;
			case SharedType.Integer:
				obj = _preferences!.getInt(name);
				break;
			case SharedType.StringVal:
				obj = _preferences!.getString(name);
				break;
		}
		return obj;
	}

	/// Remove al preferences stored and returns a future
	///
	/// if there is no instance it wait for [getInstance] to create one
	/// and then clear all preferences.
	static Future clearPreferences() async
	{
		if (_preferences == null) getInstance();
		await _preferences!.clear();
	}
}