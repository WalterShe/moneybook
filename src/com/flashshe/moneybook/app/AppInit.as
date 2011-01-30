package com.flashshe.moneybook.app
{
	import com.flashshe.moneybook.dataservice.AppDatabaseInit;
	import com.flashshe.moneybook.dataservice.DBConnection;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	
	
	/**
	 * 应用程序初始化完成后派发该事件
	 */
	[Event(name="appInitCompleted", type="flash.events.Event")]
	
	/**
	 * 负责程序启动后的初始化
	 */
	public class AppInit extends EventDispatcher
	{
		public static const APP_INIT_COMPLETED:String = "appInitCompleted";
		
		private var databaseInit:AppDatabaseInit;
		
		/**
		 * constructor
		 */
		public function AppInit(target:IEventDispatcher=null)
		{
			super(target);
			databaseInit = new AppDatabaseInit();
		}
		
		/**
		 * 执行初始化工作
		 */
		public function init():void
		{
			if (databaseInit.initialized)
			{
				openDb();
			}
			else
			{
				initAppDatabase();
			}
		}
		
		private function initAppDatabase():void
		{
			databaseInit.addEventListener(AppDatabaseInit.INIT_COMPLETED, databaseInitCompletedHandler);
			databaseInit.init();
		}
		
		private function databaseInitCompletedHandler(event:Event):void
		{
			openDb();
		}
		
		private function openDb():void
		{
			var connection:DBConnection = DBConnection.getInstance();
			connection.addEventListener(SQLEvent.OPEN, openHandler);
			connection.openAppDB();
		}
		
		private function openHandler(event:SQLEvent):void
		{
			dispatchEvent(new Event(APP_INIT_COMPLETED));
		}
	}
}