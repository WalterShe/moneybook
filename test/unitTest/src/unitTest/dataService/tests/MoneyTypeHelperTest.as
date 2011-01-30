package unitTest.dataService.tests
{
	import com.flashshe.moneybook.dataservice.MoneyTypeIdHelper;
	import flexunit.framework.Assert;
	
	
	public class MoneyTypeHelperTest
	{
		private var helper:MoneyTypeIdHelper;
		private var records:Array;
		
		[Before]
		public function setUp():void
		{
			helper = new MoneyTypeIdHelper();
			records = [{"name":"+", "id":4}, {"name":"-", "id":2}];
		}
		
		[Test(description="测试收入类型id")]
		public function getIncomeId():void
		{
			var id:int = helper.getIncomeId(records);
			Assert.assertEquals(4, id);
		}
		
		[Test(description="测试支出类型id")]
		public function getPayoutId():void
		{
			var id:int = helper.getPayoutId(records);
			Assert.assertEquals(2, id);
		}
		
		[After]
		public function tearDown():void
		{
			helper = null;
		}
		
		
	}
}