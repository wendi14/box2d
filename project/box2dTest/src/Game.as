package  
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import com.wdcgame.box2d.WDCBox2DFactory;
	import com.wdcgame.box2d.WDCBox2dFlashBasic;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class Game extends WDCBox2dFlashBasic 
	{
		 
		
		public function Game() 
		{
			 super(null);
			 
			 var b:b2Body = createBox(100, 100, 100, 100, false);
			 
			 var floor:b2Body = createBox(stage.stageWidth/2, stage.stageHeight - 10/2, stage.stageWidth, 10, true);
		}
		
	}

}