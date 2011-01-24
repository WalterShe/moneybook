package com.flashshe.moneybook.dataservice
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	/**
	 * @see flash.data.SQLConnection#event:error
	 */
	[Event(name="error", type="flash.events.SQLEvent")]
	
	/**
	 * 封装对数据库的直接操作 
	 */
	public class SQLiteDAO extends EventDispatcher
	{
		private static var instance:SQLiteDAO;
		
		private var conn:SQLConnection;
		
		public static function getInstance():SQLiteDAO
		{
			if (instance == null)
			{
				instance = new SQLiteDAO(new singleForce()); 
			}
			
			return instance;
		}
		
		public function SQLiteDAO(singleforce:singleForce)
		{
			if (singleforce == null)
			{
				throw new Error("SQLiteDAO 是一个单类");
			}
		}
		
		/**
		 * 应用程序数据库文件
		 */
		public function get appDatabaseFile():File
		{
			var folder:File = File.applicationStorageDirectory;
			var dbFile:File = folder.resolvePath("moneybook.db");
			return dbFile;
		}
		
		/**
		 * 建立与应用程序数据库的连接
		 */
		public function openAppDB():void
		{
			if (conn)
			{
				return;
			}
			
			conn = new SQLConnection();
			conn.addEventListener(SQLEvent.OPEN, eventHandler);
			conn.addEventListener(SQLEvent.CLOSE, eventHandler);
			conn.addEventListener(SQLErrorEvent.ERROR, eventHandler);
			conn.openAsync(appDatabaseFile);
		}
		
		private function eventHandler(event:Event):void
		{
			dispatchEvent(event.clone());
		}
		
		/**
		 * 关闭与应用程序数据库的连接
		 */
		public function closeAppDB():void
		{
			if (conn)
			{
				conn.close();
				conn = null;
			}
		}
		
		/**
		 * @private
		 * 建立users表
		 */
		public function excuteSQL(sql:String):void
		{
			var createStmt:SQLStatement = new SQLStatement();
			createStmt.text = sql;
			createStmt.sqlConnection = conn;
			createStmt.addEventListener(SQLEvent.RESULT, eventHandler); 
			createStmt.addEventListener(SQLErrorEvent.ERROR, eventHandler);
			createStmt.execute();
		}
	}
}

class singleForce {};