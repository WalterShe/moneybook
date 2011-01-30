package test.unitTest.domain.tests
{
	import com.ihaveu.domain.geneGift.GeneGiftDecide;
	
	import flexunit.framework.Assert;
	
	public class GeneGiftDecideTest
	{
		private var giftDecide:GeneGiftDecide;
		
		[Before]
		public function setUp():void
		{
			giftDecide = new GeneGiftDecide();
		}
		
		[After]
		public function tearDown():void
		{
			giftDecide = null;
		}
		
		[Test]
		public function testGeneGiftStatus():void
		{
			var startTime:Date = new Date(2011, 10, 5, 20, 34);
			var endTime:Date = new Date(2011, 10, 5, 21, 05);
			var currentTime:Date = new Date(2011, 10, 5, 20, 55);
			Assert.assertEquals("openStatus", giftDecide.geneGiftStatus(startTime, endTime, currentTime));


			startTime = new Date(2011, 10, 5, 20, 34);
			endTime = new Date(2011, 10, 5, 21, 05);
			currentTime = new Date(2011, 11, 5, 20, 55);
			
			Assert.assertEquals("", giftDecide.geneGiftStatus(startTime, endTime, currentTime));
			
			startTime = new Date(2011, 10, 5, 20, 34);
			endTime = new Date(2011, 10, 5, 21, 05);
			currentTime = new Date(2011, 10, 5, 23, 55);
			
			Assert.assertEquals("endStatus", giftDecide.geneGiftStatus(startTime, endTime, currentTime));
			
			startTime = new Date(2011, 10, 5, 20, 34);
			endTime = new Date(2011, 10, 5, 21, 05);
			currentTime = new Date(2011, 9, 5, 23, 55);
			
			Assert.assertEquals("advanceStatus", giftDecide.geneGiftStatus(startTime, endTime, currentTime));
			
			startTime = new Date(2011, 10, 5, 20, 34);
			endTime = new Date(2011, 10, 5, 21, 05);
			currentTime = new Date(2011, 10, 6, 00, 00);
			
			Assert.assertEquals("endStatus", giftDecide.geneGiftStatus(startTime, endTime, currentTime));
			
			startTime = new Date(2011, 10, 5, 20, 34);
			endTime = new Date(2011, 10, 5, 21, 05);
			currentTime = new Date(2011, 10, 5, 21, 06);
			
			Assert.assertEquals("endStatus", giftDecide.geneGiftStatus(startTime, endTime, currentTime));
			
			startTime = new Date(2011, 10, 5, 20, 34);
			endTime = new Date(2011, 10, 5, 21, 05);
			currentTime = new Date(2011, 10, 5, 21, 04);
			
			Assert.assertEquals("openStatus", giftDecide.geneGiftStatus(startTime, endTime, currentTime));
			
			startTime = new Date(2011, 10, 5, 20, 34);
			endTime = new Date(2011, 10, 5, 21, 05);
			currentTime = new Date(2011, 10, 5, 20, 33);
			
			Assert.assertEquals("advanceStatus", giftDecide.geneGiftStatus(startTime, endTime, currentTime));
		}
		
		[Test]
		public function testSetShowGift():void
		{
			var startTime:Date = new Date(2011, 10, 5, 20, 34);
			var endTime:Date = new Date(2011, 10, 5, 21, 05);
			var currentTime:Date = new Date(2011, 10, 5, 20, 55);
	
			var test1:Array = [{"title":"test1", "endTime":endTime, "startedTime":startTime, "currentTime":currentTime}];
			giftDecide.setShowGift(test1);
			var result1:Object = giftDecide.getShowGift();
			
			Assert.assertEquals(test1[0].title, result1.title);
			
			var test2:Array = [{"title":"test1", "endTime":endTime, "startedTime":startTime, "currentTime":currentTime},
								{"title":"test2", "endTime":new Date(2011, 10, 5, 21, 05), "startedTime":new Date(2011, 10, 5, 20, 34), "currentTime":new Date(2011, 9, 5, 23, 55)}];
			giftDecide.setShowGift(test2);
			result1 = giftDecide.getShowGift();
			
			Assert.assertEquals(test2[0].title, result1.title);
			
			var test3:Array = [{"title":"test1", "endTime":endTime, "startedTime":startTime, "currentTime":currentTime},
				{"title":"test2", "endTime":new Date(2011, 10, 5, 21, 05), "startedTime":new Date(2011, 10, 5, 20, 34), "currentTime":new Date(2011, 9, 5, 23, 55)},
				{"title":"test3", "endTime":new Date(2011, 10, 5, 21, 05), "startedTime":new Date(2011, 10, 5, 20, 34), "currentTime":new Date(2011, 9, 5, 23, 55)}];
			giftDecide.setShowGift(test3);
			result1 = giftDecide.getShowGift();
			
			Assert.assertEquals(test3[0].title, result1.title);
			
			var test4:Array = [{"title":"test1", "endTime":new Date(2011, 10, 5, 21, 05), "startedTime":new Date(2011, 10, 5, 20, 34), "currentTime":new Date(2011, 10, 5, 23, 55)},
				{"title":"test2", "endTime":new Date(2011, 10, 5, 21, 05), "startedTime":new Date(2011, 10, 5, 20, 34), "currentTime":new Date(2011, 10, 7, 23, 55)},
			{"title":"test3", "endTime":new Date(2011, 10, 5, 21, 05), "startedTime":new Date(2011, 10, 5, 20, 34), "currentTime":new Date(2011, 10, 5, 20, 20)}];
			giftDecide.setShowGift(test4);
			result1 = giftDecide.getShowGift();
			
			Assert.assertEquals(test4[0].title, result1.title);
			
			
		}
	}
}