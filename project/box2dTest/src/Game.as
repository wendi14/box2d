package  
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import com.wdcgame.box2d.WDCBox2DFactory;
	import com.wdcgame.box2d.WDCBox2dFlashBasic;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class Game extends WDCBox2dFlashBasic 
	{
		private var _levelMc:MovieClip;
		 
		
		public function Game() 
		{
			 super(null);
			 
			 //var b:b2Body = createBox(100, 100, 100, 100, false);
			 
			 //var floor:b2Body = createBox(stage.stageWidth / 2, stage.stageHeight - 10 / 2, stage.stageWidth, 10, true);
			 
			 initLevel()
		}
		
		private function initLevel():void 
		{
			_levelMc = new aa();
			 for (var i:int = 0; i < _levelMc.numChildren; i++) 
			{
				 
				var mc:MovieClip = _levelMc.getChildAt(i) as MovieClip;
				if (mc is head)
				{
					 var _head:b2Body = createCircle(mc.x,mc.y,mc.width/2,false);
				}else if (mc is floor) 
				{
					var _floor:b2Body = createBox(mc.x, mc.y, mc.width, mc.height, true);;
				}else if (mc is b1) 
				{
					var _stone:b2Body = createBox(mc.x, mc.y, mc.width, mc.height, false);;
				}
				
			}
		}
		
		private function initStone():void 
		{
			
			
			
		}
		
		private function initHead():void 
		{
			
		}
		
	}

}