package ab.flex.utils.flexunit.signals
{
	import flash.events.Event;
	
	public class AsyncSignalHandlerEvent extends Event
	{
		private var _args:Array;
		
		public function AsyncSignalHandlerEvent(type:String, args:Array)
		{
			_args = args;
			super(type, false, false);
		}
		
		public function get args():Array
		{
			return _args;
		}
		
		public function getSignalArgument(index:uint):*
		{
			return args[index];
		}
	}
}