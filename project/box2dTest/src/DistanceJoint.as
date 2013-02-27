package  
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2MouseJoint;
	import Box2D.Dynamics.Joints.b2MouseJointDef;
	import com.wdcgame.box2d.WDCBox2DFactory;
	import com.wdcgame.box2d.WDCBox2dFlashBasic;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class DistanceJoint extends WDCBox2dFlashBasic 
	{
		 
		private var mouseJoint:b2MouseJoint;
		public function DistanceJoint() 
		{
			super(null);
		}
		
		override protected function init():void 
		{
			var b1:b2Body=createBox(10, 100, 50, 50, false);
			var b2:b2Body = createBox(100, 100, 30, 30, false);
			
			var _distanceJointDef:b2DistanceJointDef = new b2DistanceJointDef();
			_distanceJointDef.bodyA = b1;
			_distanceJointDef.bodyB = b2;
			_distanceJointDef.length = 100/WDCBox2DFactory.WORLD_SCALE;
			
			_world.CreateJoint(_distanceJointDef);
			var floor:b2Body = createBox(stage.stageWidth / 2, stage.stageHeight - 5, stage.stageWidth, 10, true);
			 stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown)
			super.init();
		}
		private function onMouseDown(e:MouseEvent):void 
		{
			_world.QueryPoint(queryCallBack, mouseToWorld());
		}
		
		private function mouseToWorld():b2Vec2 
		{
			return new b2Vec2(mouseX/WDCBox2DFactory.WORLD_SCALE, mouseY/WDCBox2DFactory.WORLD_SCALE)
		}
		
		private function queryCallBack(fix:b2Fixture):Boolean 
		{
			trace("queryCallBack: " + queryCallBack);
			var body:b2Body = fix.GetBody();
			var joinDef:b2MouseJointDef = new b2MouseJointDef();
			joinDef.bodyA = _world.GetGroundBody();
			joinDef.bodyB = body;
			joinDef.target = mouseToWorld();
			joinDef.maxForce = 1000 * body.GetMass();
			mouseJoint = _world.CreateJoint(joinDef) as b2MouseJoint;
			stage.addEventListener(MouseEvent.MOUSE_MOVE,moveJoint);
			stage.addEventListener(MouseEvent.MOUSE_UP,killJoint);
			return false;
			
		}
		
		private function moveJoint(e:MouseEvent):void 
		{
			mouseJoint.SetTarget(mouseToWorld());
		}
		
		private function killJoint(e:MouseEvent):void 
		{
			_world.DestroyJoint(mouseJoint);
		}
 
 
		
	}

}