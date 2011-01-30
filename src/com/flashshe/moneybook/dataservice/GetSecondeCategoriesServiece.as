package com.flashshe.moneybook.dataservice
{
	import com.flashshe.moneybook.domain.IGetSecondCategoriesServiece;
	
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.utils.Dictionary;

	public class GetSecondeCategoriesServiece implements IGetSecondCategoriesServiece
	{
		protected var dbConn:DBConnection;
		private var isPayout:Boolean = true;
		private var requestDic:Dictionary = new Dictionary();
		
		public function GetSecondeCategoriesServiece()
		{
			dbConn = DBConnection.getInstance();
		}
		
		/**
		 * @inheritDoc
		 */
		public function getCategories(isPayout:Boolean=true):void
		{
			//this.isPayout = isPayout;
			var stmt:SQLStatement = new SQLStatement();
			requestDic[stmt] = isPayout;
			
			var sql:String = "SELECT id, name FROM moneyType";
			stmt.text = sql;
			stmt.sqlConnection = dbConn.connection;
			stmt.addEventListener(SQLEvent.RESULT, getMoneyTypeSuccessHandler);
			stmt.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			stmt.execute();
		}
		
		private function getMoneyTypeSuccessHandler(event:SQLEvent):void
		{
			var stmt:SQLStatement = SQLStatement(event.target);
			var result:SQLResult = stmt.getResult();
			var list:Array = result.data;
			var moneyTypeId:int;
			if (requestDic[stmt])
			{
				moneyTypeId = new MoneyTypeIdHelper().getPayoutId(list);
			}
			else
			{
				moneyTypeId = new MoneyTypeIdHelper().getPayoutId(list);
			}
			
			var stmt2:SQLStatement = new SQLStatement();
			
			requestDic[stmt2] = requestDic[stmt];
			delete requestDic[stmt];
			
			var sql:String = "SELECT secondCategory.*, moneType.name";
			sql += " FROM secondCategory, firstCategory, moneyType";
			sql += " WHERE secondCategory.firstCategory = firstCategory.id AND firstCategory.moneyType = moneyType.id AND moneyType.id = " + moneyTypeId;
			stmt2.text = sql;
			stmt2.sqlConnection = dbConn.connection;
			stmt2.addEventListener(SQLEvent.RESULT, getCategorySuccessHandler);
			stmt2.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			stmt2.execute();
		}
		
		private function getCategorySuccessHandler(event:SQLEvent):void
		{
			var stmt:SQLStatement = SQLStatement(event.target);
			var result:SQLResult = stmt.getResult();
			var list:Array = result.data;
		}
		
		private function errorHandler(event:SQLErrorEvent):void
		{
			trace("error: " + event.error.message);
		}
	}
}