package unitTest.app.tests
{
	import com.flashshe.moneybook.app.AppInit;
	import com.flashshe.moneybook.dataservice.DBConnection;
	import flash.events.Event;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	
	public class AppInitTest
	{
		[Before]
		public function setUp():void
		{
			
		}
		
		[Test(async)]
		public function initTest():void
		{
			var appinit:AppInit = new AppInit();
			var passThroughData:Object = null;
			appinit.addEventListener(AppInit.APP_INIT_COMPLETED, Async.asyncHandler(this, successHandler, 100, passThroughData, neverOccuredHandler1), 
			false, 0, true );
			appinit.init();
		}
		
		private function successHandler(event:Event, passThroughData:Object):void
		{
			Assert.assertNotNull(DBConnection.getInstance().connection);
			Assert.assertEquals(AppInit.APP_INIT_COMPLETED, event.type);
		}
		
		private function neverOccuredHandler1(passThroughData:Object):void
		{
			Assert.fail(AppInit.APP_INIT_COMPLETED + ' event never happended');
		}
		
		[After]
		public function tearDown():void
		{
			
		}
	}
}