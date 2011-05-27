package flexUnitTests.ab.flex.utils.flexunit.signals
{
	import ab.flex.utils.flexunit.signals.AsyncSignalHandler;
	import ab.flex.utils.flexunit.signals.AsyncSignalHandlerEvent;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.osflash.signals.Signal;

	public class AsyncSignalHandlerTests
	{		
		private var _asyncSignalHandler:AsyncSignalHandler;
		
		private var testSignal:Signal;
		private var testDelay:Number;
		private var testPassThrough:Object;
		
		private const testArgOne:String = "a string";
		private const testArgTwo:Object = new Object();
		private const testArgThree:Array = new Array();
		private const testSignalWithThreeArgs:Signal = new Signal(String, Object, Array);
		
		
		[Before]
		public function setUp():void
		{
			testSignal = new Signal();
			testDelay = 1000;
			testPassThrough = new Object();
		}
		
		[After]
		public function tearDown():void
		{
			testSignal = null;
			testDelay = 0;
			testPassThrough = null;
		}
		
		[Test(async)]
		public function AsyncSignalHandler_onInstantiation_getEventNameReturnsUniqueEventName():void
		{
			const asyncSignalHandler:AsyncSignalHandler = new AsyncSignalHandler(this, 
																				 testSignal, 
																				 testResponseHandlerEmpty, 
																				 testDelay, 
																				 testPassThrough, 
																				 testTimeoutHandlerEmpty);
			
			assertTrue(asyncSignalHandler.eventName is String);
		}
		private function testResponseHandlerEmpty(event:AsyncSignalHandlerEvent, passThrough:Object=null):void
		{
			// TODO Auto Generated method stub
		}
		private function testTimeoutHandlerEmpty(passThrough:Object):void
		{
			// TODO Auto Generated method stub
		}
		
		
		[Test(async)]
		public function AsyncSignalHandler_onSignalDispatched_testResponseHandlerExecuted():void
		{
			const asyncSignalHandler:AsyncSignalHandler = new AsyncSignalHandler(this, 
																				 testSignal, 
																				 testResponseHandler, 
																				 testDelay, 
																				 testPassThrough, 
																				 testTimeoutHandler);
			
			testSignal.dispatch();
		}
		private function testResponseHandler(event:AsyncSignalHandlerEvent, passThrough:Object=null):void
		{
			assertTrue(true);
		}
		private function testTimeoutHandler(passThrough:Object):void
		{
			fail("This test should not have timed out.");
		}
		
		
		
		[Test(async)]
		public function AsyncSignalHandler_onSignalWithThreeArgumentsDispatched_testResponseHandlerReceivesAllArguments():void
		{
			const asyncSignalHandler:AsyncSignalHandler = new AsyncSignalHandler(this, 
																				 testSignal, 
																				 testResponseHandlerForTestWithThreeSignalArguments, 
																				 testDelay, 
																				 testPassThrough, 
																				 testTimeoutHandlerForTestWithThreeSignalArguments);
			
			testSignal.dispatch(testArgOne, testArgTwo, testArgThree);
		}
		private function testResponseHandlerForTestWithThreeSignalArguments(event:AsyncSignalHandlerEvent, passThrough:Object=null):void
		{
			assertAllSignalArgsReceived(event);
		}
		private function assertAllSignalArgsReceived(event:AsyncSignalHandlerEvent):void
		{
			assertEquals(testArgOne, event.getSignalArgument(0));
			assertEquals(testArgTwo, event.getSignalArgument(1));
			assertEquals(testArgThree, event.getSignalArgument(2));
		}
		private function testTimeoutHandlerForTestWithThreeSignalArguments(passThrough:Object):void
		{
			fail("This test should not have timed out.");
		}
		
		
		
		[Test(async, timeout="1000")]
		public function AsyncSignalHandler_signalNotDispatchedDuringTest_timeOutHandlerInvoked():void
		{
			const asyncSignalHandler:AsyncSignalHandler = new AsyncSignalHandler(this, 
																				 testSignal, 
																				 testResponseHandlerEmpty, 
																				 900, 
																				 testPassThrough, 
																				 testTimeoutHandlerGetsInvoked);
		}
		private function testTimeoutHandlerGetsInvoked(passThrough:Object):void
		{
			assertTrue(true);
		}
		
		
		
		[Test(async)]
		public function AsyncSignalHandler_onSignalDispatched_passThroughObjectPassedAlongToResponseHandler():void
		{
			const asyncSignalHandler:AsyncSignalHandler = new AsyncSignalHandler(this, 
																				 testSignal, 
																				 testResponseHandlerCheckPassThrough, 
																				 testDelay, 
																				 testPassThrough, 
																				 testTimeoutHandler);
			
			testSignal.dispatch();
		}
		private function testResponseHandlerCheckPassThrough(event:AsyncSignalHandlerEvent, passThrough:Object=null):void
		{
			assertEquals(testPassThrough, passThrough);
		}
		private function testTimeoutHandlerCheckPassThrough(passThrough:Object):void
		{
			fail("This test should not have timed out.");
		}
	}
}