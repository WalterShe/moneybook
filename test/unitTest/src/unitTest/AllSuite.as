package unitTest
{
	import unitTest.app.AppSuite;
	import unitTest.dataService.DataServiceSuite;
	import unitTest.domain.DomainSuite;
	import unitTest.util.UtilSuite;
	import unitTest.view.ViewSuite;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class AllSuite
	{
		public var appSuite:AppSuite;
		public var dataServiceSuite:DataServiceSuite;
		//public var domainSuite:DomainSuite;
		//public var viewSuite:ViewSuite; 
		//public var utilSuite:UtilSuite;
	}
}