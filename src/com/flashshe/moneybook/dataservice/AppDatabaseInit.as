package com.flashshe.moneybook.dataservice
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	[Event(name="initCompleted", type="flash.events.Event")]
	
	/**
	 * 负责初始化应用程序必须的数据库
	 */
	public class AppDatabaseInit extends EventDispatcher
	{
		private var conn:SQLConnection;
		private var dao:SQLiteDAO;
		
		public function AppDatabaseInit()
		{
			super(null);
			dao = SQLiteDAO.getInstance();
		}
		
		/**
		 * <code>true</code>表示应用程序的必须数据库已经建立好，否则表示没有
		 */
		public function get initialized():Boolean
		{
			return false;//dao.appDatabaseFile.exists;
		}		
		
		/**
		 * 建立应用程序必须的数据库
		 */
		public function init():void
		{
			if (initialized)
			{
				return;
			}
			
			dao.openAppDB();
			dao.addEventListener(SQLEvent.OPEN, openHandler);
			dao.addEventListener(SQLErrorEvent.ERROR, openErrorHandler);
		}
		
		private function openHandler(event:SQLEvent):void
		{
			createUserTable();
		}
		
		private function openErrorHandler(event:SQLErrorEvent):void
		{
			trace("openAppDbError: " + event.error.message);
		}
		
		/**
		 * @private
		 * 建立users表
		 */
		private function createUserTable():void
		{
			var sql:String += "CREATE TABLE IF NOT EXISTS users ("; 
			sql += " userName TEXT PRIMARY KEY,"; 
			sql += " password TEXT"; 
			sql += ")"; 
			dao.addEventListener(SQLEvent.RESULT, createUserResultHandler); 
			dao.addEventListener(SQLErrorEvent.ERROR, createUserErrorHandler);
			dao.excuteSQL(sql);
		}
		
		private function createUserResultHandler(event:SQLEvent):void
		{
			createCategoryTable();
		}
		
		private function createUserErrorHandler(event:SQLErrorEvent):void
		{
			trace("createUserError: " + event.error.message);
		}
		
		/**
		 * @private
		 * 建立分类（比如衣食住行等）
		 */
		private function createCategoryTable():void
		{
			var sql:String += "CREATE TABLE IF NOT EXISTS category ("; 
			sql += " id INTEGER PRIMARY KEY AUTOINCREMENT,"; 
			sql += " name TEXT,"; 
			sql += " type TEXT,"; // 支出(-)还是收入(+)
			sql += " description TEXT"; 
			sql += ")"; 
			dao.addEventListener(SQLEvent.RESULT, createCategoryResultHandler); 
			dao.addEventListener(SQLErrorEvent.ERROR, createCategoryErrorHandler);
			dao.excuteSQL(sql);
		}
		
		private function createCategoryErrorHandler(event:SQLErrorEvent):void
		{
			trace("createCategoryError: " + event.error.message);
		}
		
		private function createCategoryResultHandler(event:SQLEvent):void
		{
			dispatchCompleteEvent();
			return;
			initCategory());
		}
		
		private function initCategory():void
		{
			insertCategory("食物");
			insertCategory("服饰");
			insertCategory("住房");
			insertCategory("交通");
			insertCategory("收入");
		}
		
		private function insertCategory(category:String):void
		{
			var sql:String += "INSERT INTO category (name, type, description) "; 
			sql += "VALUES ('" + category + "', '-', '')"; 
			dao.addEventListener(SQLEvent.RESULT, insertResultHandler); 
			dao.addEventListener(SQLErrorEvent.ERROR, insertErrorHandler); 
			dao.excuteSQL(sql);
		}
		
		private function insertResultHandler(event:SQLEvent):void
		{
			dispatchCompleteEvent();
		}	
		
		private function insertErrorHandler(event:SQLErrorEvent):void
		{
			trace("insertCategoryError: " + event.error.message);
		}	
		
		private function dispatchCompleteEvent():void
		{
			dispatchEvent(new Event("initCompleted"));
		}
	}
}