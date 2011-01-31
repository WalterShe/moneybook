package com.flashshe.moneybook.dataservice
{
	import com.flashshe.moneybook.domain.IGetSecondCategoriesServiece;
	import com.flashshe.moneybook.domain.SecondCategoryVO;
	import com.flashshe.moneybook.domain.events.GetSecondeCategoryEvent;
	
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.EventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.utils.Dictionary;
	
	
	public class GetSecondeCategoriesServiece extends EventDispatcher 
											implements IGetSecondCategoriesServiece
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
			
			var sql:String = "SELECT secondCategory.*";
			sql += " FROM secondCategory, firstCategory, moneyType";
			sql += " WHERE secondCategory.firstCategory = firstCategory.id ";
			sql += 	"AND firstCategory.moneyType = moneyType.id AND ";
			sql += 	("moneyType.id = " + moneyTypeId);
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
			
			var len:int = list.length;
			var vos:Vector.<SecondCategoryVO> = new Vector.<SecondCategoryVO>(len);
			for (var i:int=0; i<len; i++)
			{
				var vo:SecondCategoryVO = new SecondCategoryVO();
				vo.description = list[i]["description"];
				vo.name = list[i]["name"];
				vo.id = list[i]["id"];
				vo.firstCategoryId = list[i]["firstCategory"];
				vos.push(vo);
			}
			
			var getSecondeCategoryEvent:GetSecondeCategoryEvent = new GetSecondeCategoryEvent(vos, requestDic[stmt]);
			dispatchEvent(getSecondeCategoryEvent);
			delete requestDic[stmt];
		}
		
		private function errorHandler(event:SQLErrorEvent):void
		{
			trace("error: " + event.error.message);
		}
	}
}