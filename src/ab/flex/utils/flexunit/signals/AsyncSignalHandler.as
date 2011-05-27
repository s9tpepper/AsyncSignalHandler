package ab.flex.utils.flexunit.signals
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.utils.UIDUtil;
	
	import org.flexunit.async.Async;
	import org.osflash.signals.Signal;

	public class AsyncSignalHandler extends EventDispatcher
	{
		private var _signal:Signal;
		private var _event:String;
		private var _responseHandler:Function;
		private var _delay:Number;
		private var _testCase:Object;
		private var _passThrough:Object;
		private var _timeoutHandler:Function;
		
		public function AsyncSignalHandler(testCase:Object, signal:Signal, responseHandler:Function, delay:Number=5000, passThrough:Object=null, timeoutHandler:Function=null)
		{
			_initializeHandler(testCase, signal, responseHandler, delay, passThrough, timeoutHandler);
		}
		
		private function _initializeHandler(testCase:Object, signal:Signal, responseHandler:Function, delay:Number=5000, passThrough:Object=null, timeoutHandler:Function=null):void
		{
			_signal = signal;
			_responseHandler = responseHandler;
			_delay = delay;
			_testCase = testCase;
			_event = UIDUtil.createUID();
			_passThrough = passThrough;
			_timeoutHandler = timeoutHandler;
		
			Async.handleEvent(_testCase, this, _event, responseHandler, delay, _passThrough, _timeoutHandler);
			_signal.addOnce(onSignalDispatched);
		}
		
		public function onSignalDispatched(a:*=null,b:*=null,c:*=null,d:*=null,e:*=null,f:*=null,g:*=null,h:*=null,i:*=null,j:*=null,k:*=null,l:*=null,m:*=null,n:*=null,o:*=null):void
		{
			dispatchEvent(new AsyncSignalHandlerEvent(eventName, arguments));
		}
		
		public function get eventName():String
		{
			return _event;
		}
	}
}