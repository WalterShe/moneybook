package test.unitTest.view.tests
{
	import com.ihaveu.component.Image;
	import com.ihaveu.view.geneGift.GeneGiftPanelView;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import spark.components.RichText;
	
	public class GeneGiftPanelViewTest
	{		
		private var geneGiftPanelView:GeneGiftPanelView;
		private var geneGiftImage:Image;
		private var title:RichText;
		
		[Before (async)]
		public function setUp():void
		{
			geneGiftImage = new Image();
			title = new RichText();
			geneGiftPanelView = new GeneGiftPanelView();
			geneGiftPanelView.addElement(title);
			geneGiftPanelView.addElement(geneGiftImage);
		}
		
		[After (async)]
		public function tearDown():void
		{
			geneGiftImage = null;
			title = null;
			geneGiftPanelView = null;
		}

		[Test (async)]
		public function testDataChage():void
		{
			var passThroughData:Object = {"title": "this is title", "image":"www.ihave.com/ddd.jpg"};
			var timer:Timer = new Timer(100, 1);
			timer.addEventListener(TimerEvent.TIMER, Async.asyncHandler(this, handleVerify, 200, passThroughData, handleEventNeverOccurred), false, 0, true);
			geneGiftPanelView.dataProvider = passThroughData;
			//geneGiftPanelView.geneGiftImage.setStyle("brokenImageSkin",passThroughData.image);
			timer.start();
		}
		
		private function handleVerify(event:Event, passThroughData:Object):void
		{
			Assert.assertEquals(geneGiftPanelView.title.text, passThroughData.title);
			Assert.assertEquals(geneGiftPanelView.geneGiftImage.source, passThroughData.image);
		}
		
		private function handleEventNeverOccurred(passThroughData:Object):void
		{
			Assert.fail("Data pass is wrong!")
		}
		
	}
}