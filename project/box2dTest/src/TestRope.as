package  
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import com.wdcgame.box2d.MouseJoint;
	import com.wdcgame.box2d.Rope;
	import com.wdcgame.box2d.WDCBox2dFlashBasic;
	import flash.display.Sprite;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class TestRope extends  WDCBox2dFlashBasic 
	{
		private var _head:b2Body;
		private var _jj:MouseJoint;
		
		public function TestRope() 
		{
			super(null);
		}
		
		override protected function init():void 
		{
			super.init();
			
			buildHead()
			var rope:Rope = new Rope();
			rope.buildRope(_world, _head, 6);
			//rope.jj.SetTarget(new b2Vec2(3.8,5));
			_jj = rope.jj;
			//setTimeout(aaa, 4000);
			rope.b.ApplyForce(new b2Vec2(500), rope.b.GetWorldCenter());
			//buildRope(10);
		}
		
		private function buildHead():void 
		{
			_head = createBox(300, 80, 100, 10, true);
		}
		
		private function buildRope(n:Number):void 
		{
			var joinDef:b2RevoluteJointDef = new b2RevoluteJointDef();
			var yy:int = 100;
			var preBody:b2Body=_head;
			var anchor:b2Vec2 = _head.GetWorldCenter();;
			for (var i:int = 0; i <10; i++) 
			{
				var item: b2Body = createBox(300, yy, 2, 30, false);
				joinDef.Initialize(preBody, item, anchor);
				preBody = item;
				anchor = item.GetWorldCenter();
				_world.CreateJoint(joinDef);
				yy += 30;
				
				
			}trace("yy: " + yy);
			var _b:b2Body = createCircle(300,yy, 10, false);
			joinDef.Initialize(preBody, _b, anchor);
			_world.CreateJoint(joinDef);
			
			_b.ApplyForce(new b2Vec2(500), _b.GetWorldCenter());
			
			//_jj = new MouseJoint(_world, _b, _b.GetWorldCenter());
			//_jj.SetTarget(new b2Vec2(0,6));
			//setTimeout(aaa, 4000);
		}
		
		private function aaa():void 
		{
			_jj.DestroyJoint();
		}
		
		override protected function onRender():void 
		{
			super.onRender();
		}
	}

}