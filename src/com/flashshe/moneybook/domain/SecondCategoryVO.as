package com.flashshe.moneybook.domain
{
	/**
	 * 二级分类VO
	 */
	public class SecondCategoryVO
	{
		/**
		 * 类型（收入或者支出）id
		 */
		public var moneyTypeId:int = -1;
		
		/**
		 * 一级分类id
		 */
		public var firstCategoryId:int = -1;
		
		/**
		 * 二级分类id
		 */
		public var id:int = -1;
		
		/**
		 * 二级分类名称
		 */
		public var name:String = "";
		
		/**
		 * 二级分类描述
		 */
		public var description:String = "";
		
		
		public function SecondCategoryVO()
		{
		}
	}
}