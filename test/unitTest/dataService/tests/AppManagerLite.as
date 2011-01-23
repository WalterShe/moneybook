package test.unitTest.dataService.tests
{
	import com.ihaveu.dataService.IResourceURL;
	import com.ihaveu.dataService.IServerTime;
	import com.ihaveu.dataService.ISession;
	
	public class AppManagerLite implements IResourceURL, ISession, IServerTime
	{
		public function AppManagerLite()
		{
		}
		
		public function getImageServer(path:String):String
		{
			return path;
		}
		
		public function get baseURL():String
		{
			return null;
		}
		
		public function get session_key():String
		{
			return null;
		}
		
		public function hasSession():Boolean
		{
			return false;
		}
		
		public function getCurrentTime():Date
		{
			return new Date();
		}
	}
}