package test.unitTest.dataService.tests
{
	import com.ihaveu.dataService.geneGift.GetGeneGiftDataService;
	import com.ihaveu.domain.geneGift.events.GetGeneGiftDataEvent;
	
	import flash.events.Event;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	public class GetGeneGiftDataServiceTest
	{
		private var result:Object = {"goods":[{"ended_at":"2011-02-11T14:09:00+08:00",	
			"item":{"product": 
				{"images":[{"medium":"/image/auction/image/000/002/266/medium/9090105223c1f260f0d0e188fec9d279.png"}]}
			},
			"name":	"将要拍卖将要拍卖将要拍卖将要拍卖将要拍卖将要拍卖将要",
			"started_at":"2011-01-31T14:09:00+08:00"
		}]};
		
		private var service:GetGeneGiftDataService;
		
		[Before]
		public function setUp():void
		{
			var appLite:AppManagerLite = new AppManagerLite();
			service = new GetGeneGiftDataService(appLite, appLite, appLite);
		}
		
		[After]
		public function tearDown():void
		{
			service = null;
		}
		
		[Test(async, description="返回数据包含了错误信息")]
		public function errorTest():void
		{
			var passThroughData:Object = null;
			service.addEventListener("backendError", Async.asyncHandler(this, successHandler1, 100, passThroughData, neverOccuredCloseHandler1), 
				false, 0, true );
			service.resultAnalysis({error:"error"});
		}
		
		private function successHandler1(event:Event, passThroughData:Object):void
		{
			Assert.assertEquals("backendError", event.type);
		}
		
		private function neverOccuredCloseHandler1(passThroughData:Object):void
		{
			Assert.fail('error event never happended');
		}
		
		[Test(async, description="返回数据正确的返回")]
		public function successTest():void
		{
			var passThroughData:Object = null;
			
			service.addEventListener(GetGeneGiftDataEvent.GET_GIFTDATA, Async.asyncHandler(this, successHandler2, 100, passThroughData, neverOccuredCloseHandler2), 
				false, 0, true );
			service.resultAnalysis(result);
		}
		
		private function successHandler2(event:GetGeneGiftDataEvent, passThroughData:Object):void
		{
			Assert.assertEquals(GetGeneGiftDataEvent.GET_GIFTDATA, event.type);
			var goodsArray:Array = event.giftDataArr;
			
			Assert.assertEquals(goodsArray.length, 1);
			
			var goods:Object = goodsArray[0];
			Assert.assertEquals(goods["title"], result.goods[0].name);
			Assert.assertEquals(goods["image"], result.goods[0].item.product.images[0].medium);
		}
		
		private function neverOccuredCloseHandler2(passThroughData:Object):void
		{
			Assert.fail('GetGeneGiftDataEvent event never happended');
		}
		
	}
}