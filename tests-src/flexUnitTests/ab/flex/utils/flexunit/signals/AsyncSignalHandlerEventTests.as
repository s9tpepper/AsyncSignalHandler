package flexUnitTests.ab.flex.utils.flexunit.signals
{
	import ab.flex.utils.flexunit.signals.AsyncSignalHandlerEvent;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.fail;

	public class AsyncSignalHandlerEventTests
	{	
		private var _testArguments:Array;
		private var _randomEventName:String;
		private var _asyncSignalHandlerEvent:AsyncSignalHandlerEvent;
		
		[Before]
		public function setUp():void
		{
			_randomEventName = Math.random().toString();
			_testArguments = [1, "a string"];
			
			_asyncSignalHandlerEvent = new AsyncSignalHandlerEvent(_randomEventName, _testArguments);
		}
		
		[After]
		public function tearDown():void
		{
			_asyncSignalHandlerEvent = null;
		}
		
		[Test]
		public function AsyncSignalHandlerEvent_onInstantiation_getArgsReturnsArrayPassedIn():void
		{
			assertEquals(_testArguments, _asyncSignalHandlerEvent.args);
		}
		
		[Test]
		public function AsyncSignalHandlerEvent_onInstantiation_getSignalArgumentAtReturnsCorrectValues():void
		{
			_assertGetSignalArgumentsReturnsCorrectValues();
		}
		private function _assertGetSignalArgumentsReturnsCorrectValues():void
		{
			assertEquals(1, _asyncSignalHandlerEvent.getSignalArgument(0));
			assertEquals("a string", _asyncSignalHandlerEvent.getSignalArgument(1));
		}
		
		[Test]
		public function getSignalArgument_invalidNegativeIndex_returnsNull():void
		{
			const invalidIndex:Number = -1;
			const arg:* = _asyncSignalHandlerEvent.getSignalArgument(invalidIndex);
			
			assertNull(arg);
		}
		
		[Test]
		public function getSignalArgument_invalidPositiveIndexThatIsOutOfRange_returnsNull():void
		{
			const invalidIndex:Number = 20;
			const arg:* = _asyncSignalHandlerEvent.getSignalArgument(invalidIndex);
			
			assertNull(arg);
		}
	}
}