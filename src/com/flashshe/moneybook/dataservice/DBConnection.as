package com.flashshe.moneybook.dataservice
{
	import flash.data.SQLConnection;
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
	 * 维护数据库连接
	 */
	public class DBConnection extends EventDispatcher
	{
		private static var instance:DBConnection;
		
		private var conn:SQLConnection;
		
		public static function getInstance():DBConnection
		{
			if (instance == null)
			{
				instance = new DBConnection(new singleForce()); 
			}
			
			return instance;
		}
		
		public function DBConnection(singleforce:singleForce)
		{
			if (singleforce == null)
			{
				throw new Error("DBConnection 是一个单类");
			}
		}		
		
		/**
		 * 数据库名称
		 */
		public function get appDbName():String
		{
			return "moneybook.db";
		}
		
		/**
		 * 数据库连接
		 */
		public function get connection():SQLConnection
		{
			return conn;
		}
		
		/**
		 * 异步的方式建立与数据库的连接
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
			var folder:File = File.applicationStorageDirectory;
			var dbFile:File = folder.resolvePath(appDbName);
			conn.openAsync(dbFile);
		}
		
		private function eventHandler(event:Event):void
		{
			dispatchEvent(event.clone());
		}
		
		/**
		 * 关闭数据库的连接
		 */
		public function closeAppDB():void
		{
			if (conn)
			{
				conn.close();
				conn = null;
			}
		}
	}
}

class singleForce {};