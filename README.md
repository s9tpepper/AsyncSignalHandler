# AsyncSignalHandler for FlexUnit and as3Signals

AsyncSignalHandler is a utility for working with as3Signals in FlexUnit. AsyncSignalHandler is 
used to handle [Test(async)] type test methods in FlexUnit, giving you easy access to the 
signal's dispatched arguments via an instance of AsyncSignalHandlerEvent.

Classes
----------

- AsyncSignalHandler
- AsyncSignalHandlerEvent


#Examples

You can see examples of using AsyncSignalHandler right in the unit tests
for the two classes. Below is a simple usage example:

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



