package com.flashshe.moneybook.dataservice
{
	/**
	 * 获取moneyType id
	 */
	public class MoneyTypeIdHelper
	{
		/**
		 * constructor
		 */
		public function MoneyTypeIdHelper()
		{
		}
		
		/**
		 * 获取收入类型的id
		 * @param records 数组，其中的元素是对象<code>{name: "", id: ""}</code>
		 * 前提条件 参数records 不能为null
		 */
		public function getIncomeId(records:Array):int
		{
			return getId(records, "+");
		}
		
		/**
		 * 获取支出类型的id
		 * @param records 数组，其中的元素是对象<code>{name: "", id: ""}</code>
		 */
		public function getPayoutId(records:Array):int
		{
			return getId(records, "-");
		}
		
		private function getId(records:Array, name:String):int
		{
			var result:int = -1;
			var len:int = records.length;
			for (var i:int=0; i<len; i++)
			{
				if (records[i]["name"] == name)
				{
					result = records[i]["id"];
					break;
				}
			}
			
			return result;
		}
	}
}