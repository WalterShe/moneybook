package com.flashshe.moneybook.domain
{
	/**
	 * 获取二级分类
	 */
	public interface IGetSecondCategoriesServiece
	{
		/**
		 * 获取分类
		 * @param isPayout <code>true</code>表示是支出的id，否则表示收入的id
		 */
		function getCategories(isPayout:Boolean=true):void;
	}
}