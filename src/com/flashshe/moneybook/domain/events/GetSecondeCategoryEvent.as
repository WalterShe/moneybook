package com.flashshe.moneybook.domain.events
{
	import com.flashshe.moneybook.domain.SecondCategoryVO;
	
	import flash.events.Event;

	/**
	 * 获取二级分类陈功后派发该事件
	 */
	public class GetSecondeCategoryEvent extends Event
	{
		public static const GET_SECOND_CATEGORY:String = "getSecondCategroyEvent";
		
		/**
		 * 分类列表
		 */
		public var categories:Vector.<SecondCategoryVO>;
		
		/**
		 * <code>true</code>表示是支出，否则表示收入
		 */
		public var isPayout:Boolean = true;
		
		
		/**
		 * 构造函数
		 * @param categories 分类列表
		 * @param isPayout <code>true</code>表示是支出，否则表示收入
		 */
		public function GetSecondeCategoryEvent(categories:Vector.<SecondCategoryVO>, 
												isPayout:Boolean=true,
												bubbles:Boolean=false, 
												cancelable:Boolean=false
												)
		{
			super(GetSecondeCategoryEvent.GET_SECOND_CATEGORY, bubbles, cancelable);
			this.categories = categories;
			this.isPayout = isPayout;
		}
		
		/**
		 * 克隆一个<code>GetSecondeCategoryEvent</code>实例
		 */
		public override function clone():Event
		{
			return new GetSecondeCategoryEvent(categories, isPayout, bubbles, cancelable);
		}
		
		/**
		 * @inheritDoc
		 */
		public override function toString():String
		{
			var result:String = "";
			result += "categories: " + categories.toString();
			result += "isPayout: " + isPayout.toString();
			result += super.toString();
			return result;
		}
	}
}