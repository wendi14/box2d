package  
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import com.wdcgame.box2d.WDCBox2dFlashBasic;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class TestRope extends  WDCBox2dFlashBasic 
	{
		private var _head:b2Body;
		
		public function TestRope() 
		{
			super(null);
		}
		
		override protected function init():void 
		{
			super.init();
			
			buildHead()
			buildRope(10);
		}
		
		private function buildHead():void 
		{
			_head = createBox(100, 80, 100, 10, true);
		}
		
		private function buildRope(n:Number):void 
		{
			var joinDef:b2RevoluteJointDef = new b2RevoluteJointDef();
			var yy:int = 100;
			var preBody:b2Body=_head;
			var anchor:b2Vec2 = _head.GetWorldCenter();;
			for (var i:int = 0; i <10; i++) 
			{
				var item: b2Body = createBox(100, yy, 2, 30, false);
				joinDef.Initialize(preBody, item, anchor);
				preBody = item;
				anchor = item.GetWorldCenter();
				_world.CreateJoint(joinDef);
				yy += 30;
				
				
			}trace("yy: " + yy);
			var _b:b2Body = createCircle(100,yy, 10, false);
			joinDef.Initialize(preBody, _b, anchor);
			_world.CreateJoint(joinDef);
			
			_b.ApplyForce(new b2Vec2(500), _b.GetWorldCenter());
		}
		
		override protected function onRender():void 
		{
			super.onRender();
		}
	}

}